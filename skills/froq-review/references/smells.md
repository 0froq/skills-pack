# Smell baseline

Used when the repo documents no coding standards of its own, and alongside them
when it does. A documented repo standard always overrides this list. Every entry
is a labelled judgement call, never a hard violation, and never something the
linter already reports.

Each one reads: what it is, then how to fix it.

**Mysterious name.** A function, variable, or type whose name does not reveal
what it does or holds. Rename it. If no honest name comes out, the design is
murky.

**Duplicated code.** The same logic shape appears in more than one hunk or file.
Extract the shared shape and call it from both.

**Feature envy.** A method that reaches into another object's data more than its
own. Move the method onto the data it envies.

**Data clumps.** The same few fields or parameters keep travelling together.
Bundle them into one type and pass that.

**Primitive obsession.** A string or number standing in for a domain concept.
Give the concept its own small type.

**Repeated switches.** The same switch or if-cascade on the same type recurs
across the change. Replace with polymorphism, or one shared map.

**Shotgun surgery.** One logical change forces scattered edits across many
files. Gather what changes together into one module.

**Divergent change.** One file gets edited for several unrelated reasons. Split
it so each module changes for one reason.

**Speculative generality.** Abstraction, parameters, or hooks added for needs
the PR does not have. Delete it and inline back until a real need shows up.

**Message chains.** Long `a.b().c().d()` navigation the caller should not depend
on. Hide the walk behind one method on the first object.

**Middle man.** A class or function that mostly just delegates. Cut it and call
the real target.

**Refused bequest.** A subclass or implementer that ignores or overrides most of
what it inherits. Drop the inheritance for composition.
