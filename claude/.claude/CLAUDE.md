## Conciseness

Be extremely concise in chat responses, plans, and commit messages. Sacrifice grammar for brevity. No summaries of what you just did. Artifacts (PRDs, RFCs, code, tests) should be as thorough as necessary, but only as thorough as necessary.

## Private Notes

I keep a private notes directory at `~/notes/` for research, plans, and thinking. Structure:

- `~/notes/_global/` — cross-project notes (Claude Code research, context patterns)
- `~/notes/<project>/` — project-scoped notes (e.g., `dotfiles/`, `<repo-name>/`)

Only read these when I explicitly ask you to check my notes or reference them.

## Plan Mode

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- At the end of each plan, give me a list of unresolved questions to answer, if any.

## Design Thinking
Default to FP concepts when designing abstractions: monads, functors, algebraic data types, composition over inheritance. Name them — don't shy away from "monad" or "functor" when that's what something is. Prefer data-oriented designs (declarative graphs, state machines, context-carrying cursors) over OOP hierarchies. When a problem involves state threading, conditional branching, or sequencing effects, reach for the FP pattern first (e.g., Result/Either for errors, Flow monad for navigation, Option for nullability) and only fall back to imperative patterns if the FP version adds complexity without payoff. Tweak the specific patterns to taste — propose monadic APIs, algebraic types, composition pipelines, etc. as the default framing rather than treating them as exotic. Additionally, prefer Dependency Injection for testability and reusability. The exact flavor of DI may depend on the context and surrounding technologies.


## Code Philosophy (see `./code-philosophy.md` for full rationale)

These principles guide every design decision:

1. **Pragmatic FP** — Pure functions by default. Immutability. Composition over inheritance. Side effects at the edges.
2. **Single Level of Abstraction** — Each function operates at one level. Don't mix "what" and "how."
3. **Pragmatic DDD** — Ubiquitous language, bounded contexts, value objects. Skip the ceremony.
4. **Testability by construction** — If it's hard to test, the design is wrong. No hidden dependencies.
5. **Simple Made Easy** — Decomplect. Prefer data over objects. Be suspicious of convenience.
6. **Boring code** — Optimize for the reader. Obvious beats elegant. Never clever.
7. **Connascence** — Prefer weaker coupling. Meaning → name. Position → named params. Stronger coupling stays local.
8. **Feedback-first design** — Every decision judged by "how fast can I get feedback?" Push validation left.
9. **Engineering discipline** — Small reversible steps. Modularity. Build the simplest thing, get feedback, evolve.

When principles conflict, **feedback-first design is the tiebreaker.**
