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

## Code Philosophy

Read `~/.claude/code-philosophy.md` when designing abstractions, modules, or tests, or when reviewing a design. The principles interlock; overlap between them is deliberate reinforcement.

1. **Pragmatic FP, pushed further** — Pure core by default, then climb: make illegal states unrepresentable, parse don't validate, errors as values, effects as data, composition. Name the patterns (functor, monad). Propose the FP version first; when imperative wins, say why in one line.
2. **Single Level of Abstraction** — Each function operates at one level. Don't mix "what" and "how."
3. **Pragmatic DDD** — Ubiquitous language, bounded contexts, value objects, anti-corruption layers. Skip the ceremony.
4. **Testability by construction** — Test pain is design feedback; patching silences it. Dependency rejection → impureim sandwich → injected functions → owned ports with fakes. Mock only what you own.
5. **Simple Made Easy** — Decomplect. Data and state machines over objects and hierarchies. Be suspicious of convenience.
6. **Boring code** — Optimize for the reader. Obvious beats elegant. Never clever.
7. **Connascence** — Prefer weaker coupling. Meaning → name or type. Position → named params. Timing → type. Stronger coupling stays local.
8. **Feedback-first design** — Every decision judged by "how fast can I get feedback?" Push validation left.
9. **Engineering discipline** — Small reversible steps. Modularity. Build the simplest thing, get feedback, evolve.

When principles conflict, **feedback-first design is the tiebreaker.**
