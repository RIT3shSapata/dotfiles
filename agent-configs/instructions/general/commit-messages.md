# Commit message preferences

## Format and wording

For every commit message request, use this format:

```text
<change-type>(<component-changed>): <commit-title>

<commit-description>
```

Keep the title very short and concise.
Use present tense throughout the title and description.
Prefer direct verbs such as `Add`, `Fix`, `Update`, `Document`, and `Improve`.
Keep one blank line between the title and description.

Write the description as concise bullet points rather than a large paragraph.
Include enough detail to explain the important changes.
Group related changes by purpose or component.
Omit minor details that do not help the reader understand the change.
For related tests, use a summary such as `Add test coverage for the API component`.
Do not list every test or edited file.

## Suggest the change type

Suggest one of these change types based on the purpose of the changes:

- `feat`: Add a new feature to the project or repository.
- `fix`: Fix an issue in the project or repository.
- `task`: Do routine development work, refactor code, or update dependency versions.
- `doc`: Change documentation, including design documents and documentation for final publication.
- `improv`: Improve an existing component of the project.

Explain briefly why the suggested type fits the changes.
For an issue correction, prefer `fix`.
For a refactor or dependency update, prefer `task`.
For an improvement beyond a routine refactor, suggest `improv`.
If several types fit, explain the distinction and ask the user to choose.
Do not substitute another commit convention or change type without an explicit user request.

## Suggest the component

Use a component name that reflects the rough part of the project that changes.
Refer to the project architecture and existing component names when available.
Suggest the component name and ask the user to approve it.
If the architecture does not identify a clear component, explain the proposed name briefly.
Do not substitute an individual filename when a broader component name fits the changes.

## Obtain approval

Present the suggested type, component, and complete proposed commit message together.
Ask the user to approve the type, component, title, and description.
Treat the proposed message as a draft until the user approves all parts.
Wait for that approval before finalizing the message or creating or amending a commit.
Do not treat approval of only the type or component as approval of the entire message.
If the user requests changes, revise the draft and obtain approval of the revised message.
If the changes alter an approved message, obtain approval of the replacement message before committing.
If the user approves the complete message, reuse that approval while the message and commit scope remain unchanged.

A request for a commit message alone does not authorize creating a commit.
If the user also authorizes the commit, create it only after approval of the complete message.
Keep the approved type, component, title, and description unchanged when creating the commit.
