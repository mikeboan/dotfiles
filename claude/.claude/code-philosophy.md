# Code Philosophy

These principles guide design decisions. When two approaches both work, these principles break the tie.

## 1. Pragmatic FP

Pure functions are the default unit of work. Given the same inputs, they return the same output, with no side effects. This isn't about monads or category theory — it's about writing code that's predictable, testable, and composable.

**In practice:**

- **Data transformation pipelines over imperative mutation.** Chain `map`, `filter`, `reduce` rather than accumulating into a mutable variable. RxJS operators are FP pipelines — lean into that.
- **Immutability by default.** Don't mutate inputs. Return new objects. Spread operators and `Object.freeze` are your friends; reassignment is a smell.
- **Composition over inheritance.** Build behavior by combining small functions, not by extending base classes. If you're reaching for `extends`, ask whether a function that takes the shared behavior as a parameter would be simpler.
- **Isolate side effects at the edges.** Pure logic in the middle, I/O at the boundaries. In NgRx terms: selectors and reducers are pure; effects are the impure shell.

**The pragmatic part:** When a `for` loop is clearer than a chain of higher-order functions, use the `for` loop. FP is a tool for clarity, not a religion.

## 2. Single Level of Abstraction

Each function should operate at one level of abstraction. If a function is orchestrating high-level steps ("load user, validate permissions, render page"), it shouldn't also contain low-level details ("parse the date string, format the header"). Mix levels and the reader has to constantly zoom in and out.

**The test:** Read the function line by line. If one line is "what" and the next is "how," extract the "how" into a named function. The parent function should read like a table of contents.

**The trap:** Don't extract for extraction's sake. Three similar lines are better than a premature abstraction. Extract when the level mismatch hurts readability, not to hit some arbitrary function-length target.

## 3. Pragmatic DDD

Domain-driven design offers powerful modeling tools. Use them without the ceremony.

**Patterns worth using:**

- **Ubiquitous language.** Name things the way the business names them. If the product says "job match," the code says `JobMatch`, not `UserApplicationCorrelation`. When the domain term changes, rename in the code.
- **Bounded contexts.** Feature areas are boundaries. Each has its own models, its own state, its own vocabulary. Don't force a single `User` type to serve five features — let each context define what "user" means to it.
- **Value objects.** Small, immutable types that represent a concept — `EmailAddress`, `ResumeScore`, `DateRange`. Compare by value, not reference. They carry validation with them.
- **Aggregates.** Group entities that change together. Don't let external code reach into an aggregate's internals — expose operations, not structure.

**The pragmatic part:** You don't need an `AggregateRoot<T>` base class or a `DomainEventBus`. The patterns are valuable; the infrastructure is usually not. If you're spending more time on DDD plumbing than on modeling the domain, you've gone too far.

## 4. Testability by Construction

> "There are no secrets to writing tests — only secrets to writing testable code." — Misko Hevery

If code is hard to test, the design is wrong. The test is the first client of your API. If the test setup is painful, that pain is telling you something about coupling, hidden dependencies, or mixed responsibilities.

**Design for testability:**

- **Separate object creation from business logic.** Constructors should assign dependencies, not make decisions. Logic that happens during construction is logic you can't test in isolation.
- **No hidden dependencies.** If a function needs something, it takes it as a parameter. Global state, singletons accessed directly, and `new` inside business logic are all hidden dependencies.
- **Inject, don't import.** Angular's DI exists for this reason — use it. When you're tempted to import a concrete service and call it directly, inject the abstraction instead.
- **Small surface area.** Functions with fewer parameters and smaller return types are easier to test. If your function takes six arguments, it probably has too many responsibilities.

## 5. Simple Made Easy

> "Simplicity is a prerequisite for reliability." — Rich Hickey

Simple and easy are different things. Easy means "close at hand" — familiar, low effort to start. Simple means "not interleaved" — one concept, one purpose, no braiding. Libraries that are easy to adopt are often complex underneath. Code that's simple to understand may take more effort to write.

**Decomplect:**

- **Separate things that are not the same thing.** State from identity. Data from presentation. Domain logic from framework ceremony. If two concerns are tangled, pull them apart even if the tangled version is shorter.
- **Prefer data over objects with behavior.** Plain interfaces and functions over classes with methods. Data is transparent, inspectable, serializable, and easy to test. Objects hide things — sometimes usefully, often not.
- **Be suspicious of convenience.** When a framework offers magic (decorators that auto-wire, base classes that "handle everything"), ask what's being interleaved. The convenience might cost you simplicity.

## 6. Boring Code

Optimize for the reader, not the writer. If a reader has to stop and ask "wait, what does this do?" — it's too clever.

**In practice:**

- **Obvious > elegant.** A slightly verbose approach that any team member can read at a glance beats a terse one that requires domain expertise in language features.
- **Predictable structure.** When files, functions, and patterns follow a consistent shape, the reader can focus on what's different rather than re-parsing the structure each time. Consistent shapes reduce cognitive load.
- **Name things for the reader.** Variable and function names should make sense to someone who doesn't have your current mental context. `filteredActiveUsers` over `result`. `isEligibleForDiscount` over `check`.
- **Avoid clever tricks.** Bitwise operators for boolean logic, nested ternaries, operator overloading via type coercion — these save keystrokes and cost comprehension.

## 7. Connascence

Connascence is a framework for reasoning about coupling. Two components are connascent when a change in one requires a change in the other. Not all coupling is equal — weaker forms are preferable.

**From weakest (best) to strongest (worst):**

| Form         | Meaning                                     | Example                                                  |
| ------------ | ------------------------------------------- | -------------------------------------------------------- |
| **Name**     | Two things must agree on a name             | A function call matches a function definition            |
| **Type**     | Two things must agree on a type             | A parameter type matches what the caller passes          |
| **Meaning**  | Two things must agree on what a value means | `status: 1` means "active" in both producer and consumer |
| **Position** | Two things must agree on order              | Positional function arguments                            |
| **Timing**   | Two things must happen in a specific order  | Init before use, setup before teardown                   |

**Use this to evaluate design decisions:**

- Convert connascence of meaning to connascence of name — use enums and named constants instead of magic strings/numbers.
- Convert connascence of position to connascence of name — use option objects instead of long positional parameter lists.
- If two modules have connascence of timing, they're probably too coupled — consider decoupling through events or state.
- Stronger connascence should be closer together. Within a single function is fine. Across feature areas is a problem.

## 8. Feedback-First Design

Every design decision should be evaluated by: **"How fast can I get feedback on whether this works?"**

This is the meta-principle that justifies many of the others. Pure functions are testable in milliseconds. Small modules can be deployed independently. Clear boundaries let you reason about one thing at a time.

**In practice:**

- **Prefer designs that can be validated with a unit test** over designs that require integration tests, which require e2e tests, which require manual testing.
- **Small, focused changes over large refactors.** Each step should produce something you can verify.
- **Clear error messages.** When something fails, fast feedback means fast diagnosis. "Cannot read property 'id' of undefined" is not feedback — it's noise. Fail early, fail clearly.
- **Tight loops.** Lint catches style issues immediately. Types catch structural issues at compile time. Tests catch logic issues in seconds. Code review catches design issues in hours. Production catches everything else in days. Push validation as far left as possible.

## 9. Engineering Discipline

Inspired by David Farley's _Modern Software Engineering_: software engineering is an empirical discipline. We learn by doing, not by planning.

**Principles:**

- **Modularity.** Independent modules with clear interfaces can be understood, tested, changed, and deployed independently. When changing module A requires understanding module B, the boundary is in the wrong place.
- **Separation of concerns.** Each module, function, or class should have one reason to change. This isn't the Single Responsibility Principle as abstract dogma — it's a practical test: "if requirement X changes, how many files do I touch?"
- **Manage complexity incrementally.** Don't design for hypothetical future requirements. Build the simplest thing that works, get feedback, then evolve. The right abstraction reveals itself through use, not through upfront design.
- **Reversibility.** Prefer decisions that are easy to undo. Small functions can be inlined. Extracted modules can be merged. Feature flags can be removed. Monolithic rewrites cannot be unwound.

---

## Applying These Principles

These principles sometimes tension against each other. Pragmatic FP says "compose small functions" but Single Level of Abstraction says "don't extract prematurely." Boring Code says "be obvious" but Simple Made Easy says "pull things apart even if the tangled version is shorter."

When principles conflict, **Feedback-First Design is the tiebreaker.** Choose the approach that gets you faster, more reliable feedback on whether the code works correctly.
