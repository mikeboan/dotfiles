# Code Philosophy

These principles guide design decisions. When two approaches both work, these principles break the tie.

The principles interlock. Each is valuable alone, but they're one way of thinking seen from nine angles: a pure core makes testing trivial, testable seams become bounded-context boundaries, weak connascence keeps those boundaries cheap to change, and cheap change is what fast feedback needs. Overlap between sections is deliberate — when one principle reappears inside another, it's reinforcement.

## 1. Pragmatic FP, Pushed Further

Pure functions are the default unit of work. Most "pragmatic FP" stops there and leaves the bigger payoffs on the table: types that model the domain, errors as values, effects as data. Push further. Name the patterns — if it has `map`/`flat_map`, it's a functor/monad; say so, because the name brings its laws along for reasoning.

**The ladder — every rung is a default:**

1. **Make illegal states unrepresentable** (Yaron Minsky). Model states as sum types with exhaustive matching. `BookingStatus = Held(expires_at) | Confirmed(voucher) | Cancelled(refund) | Expired` — each state carries only its own data, so a held booking has no voucher field to forget about.
2. **Parse, don't validate** (Alexis King). Value objects get smart constructors that return a valid value or a failure. Past the edge, invalid data can't exist: a `PartyMix` with zero adults never gets constructed.
3. **Errors as values.** Expected domain failures are return values: `hold(slot, party) -> Result[Hold, SoldOut | PartyTooLarge | SlotClosed]`. Chain them — Railway Oriented Programming (Scott Wlaschin). Exceptions are for bugs and infrastructure failures, handled at the edges.
4. **Effects as data.** Pure functions return decisions — events or commands — and the imperative shell executes them: `decide(booking, command) -> list[Event]`. #4 covers how this shapes dependencies.
5. **Composition.** Build behavior from small functions in pipelines. Pricing: base price per traveler → group discount → promo → fees, each step `Price -> Price`. Composition over inheritance. For dependency injection, see #4.
6. **Immutability.** Return new values; inputs stay untouched.

**Beyond the ladder:** point-free style, higher-kinded type emulation, monad transformers, hand-rolled do-notation. Reader cost usually exceeds payoff — use them where the codebase already does.

**Team boundary:** adopting an FP library (Effect, fp-ts, `returns`) is a team decision — propose it with a concrete before/after. Until then, push FP within the codebase's existing idioms.

**The rule:** propose the FP version first. When imperative wins, it wins on the merits — state why in one line. A `for` loop that reads clearer than a fold is a legitimate winner.

**Idioms:**

| Concept      | TypeScript                                              | Python                                                         |
| ------------ | ------------------------------------------------------- | -------------------------------------------------------------- |
| Sum type     | discriminated union + `never` exhaustiveness check      | dataclasses + `match` + `assert_never`                         |
| Value object | branded type + smart constructor                        | frozen dataclass + `parse` classmethod returning a Result      |
| Result       | codebase convention; else `{ ok: true, value } \| { ok: false, error }` | codebase convention; else a small `Ok[T] \| Err[E]` union |
| Option       | `T \| undefined`                                        | `T \| None`                                                    |
| Immutability | `readonly`, `as const`, `Readonly<T>`                   | `@dataclass(frozen=True)`, tuples, `frozenset`                 |
| Pipeline     | `map` / `filter` / `reduce`                             | comprehensions, generators                                     |
| DI seam      | interface + function or constructor param               | `Protocol` + function or constructor param                     |

## 2. Single Level of Abstraction

Each function should operate at one level of abstraction. If a function is orchestrating high-level steps ("load availability, hold spots, price the booking"), it shouldn't also contain low-level details ("convert the slot to local time, round the currency"). Mix levels and the reader has to constantly zoom in and out.

**The test:** Read the function line by line. If one line is "what" and the next is "how," extract the "how" into a named function. The parent function should read like a table of contents.

**The trap:** Three similar lines beat a premature abstraction. Extract when the level mismatch hurts readability, not to hit a function-length target.

## 3. Pragmatic DDD

Domain-driven design (Eric Evans) offers powerful modeling tools. Use them without the ceremony.

**Patterns worth using:**

- **Ubiquitous language.** Name things the way the business names them. If the business says "hold," the code says `Hold`, not `TempReservation`. When the domain term changes, rename in the code.
- **Bounded contexts.** An "experience" means something different in each context: in Catalog it's a title, photos, reviews, and a meeting point; in Availability it's time slots and capacity; in Booking it's a confirmed slot, travelers, and a voucher; in Checkout it's a line item with a price. Let each context define its own model and translate at the boundaries, rather than growing a shared `LineItem` with optional `slot` and `party` fields.
- **Anti-corruption layers.** External systems — supplier APIs, the shopping app's core cart — get an adapter that translates their model into yours. Their shape stops at the boundary.
- **Value objects.** Small, immutable types that represent a concept — `Money` (amount + currency, decimal not float), `PartyMix` (adults, children, infants; at least one adult), `TimeSlot` (start in the experience's local timezone), `CancellationPolicy`. Compare by value. They carry their validation with them.
- **Aggregates.** Group entities that change together and expose operations, not structure. `SlotInventory` offers `hold(party)`; outside code goes through it rather than adjusting `remaining`.

**The pragmatic part:** The patterns are valuable; the infrastructure usually isn't. Skip the `AggregateRoot<T>` base class and the `DomainEventBus`. If you're spending more time on DDD plumbing than on modeling the domain, you've gone too far.

## 4. Testability by Construction

> "There are no secrets to writing tests — only secrets to writing testable code." — Miško Hevery

Test pain is design feedback. The test is the first client of your API; painful setup is a signal about coupling, hidden dependencies, or mixed responsibilities. Listen to the tests (Freeman & Pryce, _Growing Object-Oriented Software, Guided by Tests_).

**The numbing trap:** `mock.patch` and `jest.mock` make untestable code testable — and silence the signal. When a test reaches for patching, fix the design until the test needs no patch.

**The dependency ladder — climb only as far as needed:**

1. **Dependency rejection** (Mark Seemann). The pure core takes values, not dependencies. `refund(policy, booking, now) -> Money` takes a timestamp, not a clock. Test with plain values.
2. **Impureim sandwich** (Seemann) — **functional core, imperative shell** (Gary Bernhardt). The shell gathers data (load slot inventory), a pure function decides (`decide_hold`), the shell executes (save, call the supplier). The core is tested with values; the shell stays thin enough to cover with a few integration tests.
3. **Inject a function** when effects must interleave with decisions, like a conditional supplier lookup mid-decision. Test with a lambda.
4. **Owned port + fake.** Define a domain-shaped interface you own — `SupplierPort.fetch_availability(experience_id, date) -> list[TimeSlot]` — and test against a hand-written fake (`InMemorySupplier`) that really behaves. Assert on outcomes ("3 spots remain"), not on calls. Run one contract test suite against both the fake and the real adapter to keep the fake honest.
5. **Mock an owned port** when the interaction itself is the behavior and can't be returned as data. Rare once effects are data (#1): "send voucher" becomes a returned `SendVoucher` command.
6. **Container or patching.** A DI container only where the codebase already uses one; patching only to open seams in legacy code on the way to a better rung.

**Mock only what you own.** Wrap third-party APIs (payment SDKs, supplier HTTP clients, cloud SDKs) in an adapter you own — an anti-corruption layer (#3) — and fake that adapter's port. A mock of someone else's API encodes your assumptions about it; when those assumptions are wrong, tests pass and production fails. The adapter itself gets a few integration tests against a sandbox or recorded responses.

**Testability smells** (after Hevery):

- Constructors or module imports doing real work — I/O, decisions, network calls.
- `now()`, randomness, or environment reads inside domain logic.
- Reaching through collaborators: `booking.experience.supplier.client.get(...)`. Ask for what you need directly.
- Global state and singletons accessed directly.
- Tests that need mocks returning mocks.
- Wide surface area: a function taking six arguments has too many responsibilities.

## 5. Simple Made Easy

> "Simplicity is a prerequisite for reliability." — Rich Hickey

Simple and easy are different things. Easy means "close at hand" — familiar, low effort to start. Simple means "not interleaved" — one concept, one purpose, no braiding. Libraries that are easy to adopt are often complex underneath. Code that's simple to understand may take more effort to write.

**Decomplect:**

- **Separate things that are not the same thing.** State from identity. Data from presentation. Domain logic from framework ceremony. If two concerns are tangled, pull them apart even if the tangled version is shorter.
- **Prefer data over objects with behavior.** Plain records (dataclasses, typed objects) and functions over classes with methods. State machines and declarative data over class hierarchies. Data is transparent, inspectable, serializable, and easy to test. Objects hide things — sometimes usefully, often not.
- **Be suspicious of convenience.** When a framework offers magic (decorators that auto-wire, base classes that "handle everything," implicit global registries), ask what's being interleaved. The convenience might cost you simplicity.

## 6. Boring Code

> "Everyone knows that debugging is twice as hard as writing a program in the first place. So if you're as clever as you can be when you write it, how will you ever debug it?" — Brian Kernighan

Optimize for the reader, not the writer. If a reader has to stop and ask "wait, what does this do?" — it's too clever.

**In practice:**

- **Obvious > elegant.** A slightly verbose approach that any team member can read at a glance beats a terse one that requires expertise in obscure language features.
- **Predictable structure.** When files, functions, and patterns follow a consistent shape, the reader can focus on what's different rather than re-parsing the structure each time.
- **Name things for the reader.** Names should make sense to someone without your current mental context. `available_slots` over `result`. `is_refundable` over `check`.
- **Plain constructs.** Flat conditionals over nested ternaries, a named helper over a dense one-line comprehension, explicit code over metaprogramming and implicit coercion.
- **Boring FP.** A `Result` pipeline of well-named steps is boring; a point-free combinator chain is clever. Push FP (#1) toward the boring end.

## 7. Connascence

Connascence (Meilir Page-Jones; popularized by Jim Weirich) is a framework for reasoning about coupling. Two components are connascent when a change in one requires a change in the other. Weaker forms are preferable.

**From weakest (best) to strongest (worst):**

| Form         | Meaning                                     | Example                                                             |
| ------------ | ------------------------------------------- | ------------------------------------------------------------------- |
| **Name**     | Two things must agree on a name             | A function call matches a function definition                       |
| **Type**     | Two things must agree on a type             | A parameter type matches what the caller passes                     |
| **Meaning**  | Two things must agree on what a value means | A naive `start` datetime is UTC in one module, experience-local in another |
| **Position** | Two things must agree on order              | Positional function arguments                                       |
| **Timing**   | Two things must happen in a specific order  | A slot must be held before a booking is confirmed                   |

**Use this to evaluate design decisions:**

- Convert connascence of meaning to name or type — enums, named constants, and types that carry the meaning (timezone-aware datetimes, `Money` instead of a bare decimal).
- Convert connascence of position to name — keyword arguments and options objects instead of long positional parameter lists.
- Convert connascence of timing to type — make the order structural (confirming requires a `Hold` value) or collapse the steps into one operation.
- Keep stronger connascence close together. Within a single function is fine. Across bounded contexts is a problem.

## 8. Feedback-First Design

Every design decision should be evaluated by: **"How fast can I get feedback on whether this works?"**

This is the meta-principle that justifies the others. Pure functions are testable in milliseconds. Small modules can be deployed independently. Clear boundaries let you reason about one thing at a time.

**In practice:**

- **Prefer designs that can be validated with a unit test** over designs that require integration tests, which require e2e tests, which require manual testing.
- **Small, focused changes over large refactors.** Each step should produce something you can verify.
- **Fail early, fail clearly.** A `KeyError` three layers from the cause is noise; `PartyTooLarge(max=12, requested=15)` at the edge is feedback. Parsing at the boundary (#1) is what makes this possible.
- **Tight loops.** Lint catches style issues immediately. Type checkers catch structural issues before anything runs. Tests catch logic issues in seconds. Code review catches design issues in hours. Production catches everything else in days. Push validation as far left as possible.

## 9. Engineering Discipline

Inspired by David Farley's _Modern Software Engineering_: software engineering is an empirical discipline. We learn by doing, not by planning.

> "For each desired change, make the change easy (warning: this may be hard), then make the easy change." — Kent Beck

**Principles:**

- **Modularity.** Independent modules with clear interfaces can be understood, tested, changed, and deployed independently. When changing module A requires understanding module B, the boundary is in the wrong place.
- **Separation of concerns.** Each module or function should have one reason to change. The practical test: "if requirement X changes, how many files do I touch?"
- **Manage complexity incrementally.** Build the simplest thing that works for today's requirements, get feedback, then evolve. The right abstraction reveals itself through use, not through upfront design.
- **Reversibility.** Prefer decisions that are easy to undo. Small functions can be inlined. Extracted modules can be merged. Feature flags can be removed. Monolithic rewrites cannot be unwound.

---

## Applying These Principles

Interlocking doesn't mean frictionless. Pushing FP (#1) pulls toward abstraction; Boring Code (#6) pulls toward the obvious. Pragmatic FP says "compose small functions"; Single Level of Abstraction says "don't extract prematurely." Simple Made Easy says "pull things apart even if the tangled version is shorter."

When principles conflict, **Feedback-First Design is the tiebreaker.** Choose the approach that gets you faster, more reliable feedback on whether the code works correctly.
