# Explanation preferences

## Build the mental model

Start with a short statement of what the concept does and which problem it solves.
Assume no prior knowledge of the specific topic, even when the user knows related programming concepts.
Define unfamiliar terms before using them in a deeper explanation.
Explain one idea at a time in plain English.
Connect each new idea to the previous one.
Explain the reason for a design choice, not only its syntax or usage.

For a conceptual explanation, follow this sequence:

1. Give a brief intuition without entering the detailed explanation.
2. Show the rendered Mermaid diagram.
3. Immediately explain the diagram with bullet points.
4. Walk through the mechanism step by step.
5. Give a worked example with concrete inputs and observable results.
6. Explain relevant alternatives, tradeoffs, and common confusions.

Keep the first pass focused on the question.
Add depth where it explains a missing step or resolves a likely misunderstanding.
If the user does not understand, use a different example or a smaller diagram.
Do not repeat the same explanation with more jargon.

## Use practical examples

Prefer examples from the current project when its code or domain fits the topic.
Read the relevant code before describing how that project works.
For software topics, use realistic application behavior rather than unrelated toy examples.
Useful examples include HTTP request handling, a job dashboard, log rotation, database access, and producer-consumer queues.
For other topics, choose a concrete example from the domain under discussion.

If an everyday analogy helps, use it briefly after the diagram.
Map each part of the analogy to the technical mechanism.
State where the analogy stops matching the real behavior.
Do not substitute the analogy for the worked example.

## Explain code and execution

Start with pseudocode to show the idea without language-specific details.
If the question needs real code, follow with a focused example in the relevant language.
For existing code, use its language and retain the exact identifiers under discussion.
If no language is clear, choose one that fits the topic or ask for the preference.

Add comments that explain intent and non-obvious steps.
Trace execution from the entry point to the result.
Show concrete inputs, changes to state, and expected output when relevant.
For concurrency, explain which operations overlap and which operations wait.
For an interface or wrapper, show who calls it and how the call reaches the underlying implementation.
If the user asks for each line, explain each line without skipping the connections between them.

For Go examples, prefer current idioms that the project version supports.
Make sure that version-sensitive claims match the project and official documentation.
State the version requirement when it changes the example.
Distinguish a conceptual sketch from runnable code.
If you run an example, report the result.
If you do not run it, say so when execution matters to the answer.

## Compare and correct

When comparing approaches, use the same scenario for each approach.
Explain the problem that each approach solves and when to choose it.
If two approaches appear equivalent, explain their actual distinction before introducing more alternatives.
When the user states a partial understanding, identify the correct part before correcting the missing part.
Explain why the correction changes the behavior.
Separate observed facts from assumptions about code that you cannot inspect.

If the user asks about interviews, connect the example to a realistic design question.
Add a concise answer that the user can give in an interview.
If the user asks for notes, use the available note-making workflow.
Organize those notes by topic and include corrected misconceptions.
Do not create permanent study notes merely because the user asks for an explanation.

## Explain errors and commands

For an error, preserve its exact text.
Explain what failed, why it failed, and how the proposed fix changes the behavior.
State the directory and prerequisites for each command that depends on them.
Show the expected result so that the user can recognize success.
Use commands and features that exist in the installed tool version.
If the user asks only for an explanation or audit, keep application files unchanged.
Create the requested explanatory diagrams without treating them as permission for implementation changes.
