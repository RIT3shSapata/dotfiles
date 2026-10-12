# Diagram preferences

## Show diagrams first

For every conceptual explanation, include a Mermaid diagram, even for a small concept.
Keep a small concept diagram small.
Show the diagram before the detailed explanation or code walkthrough.
A short intuition before the diagram is acceptable.
Immediately after each diagram, give bullet points that explain its meaning.
Name the actors, boxes, arrows, decisions, or changes to state that the diagram shows.
Connect those points to the worked example that follows.

Use a sequence diagram for interactions over time.
Use a flowchart for decisions, dependencies, or movement through a process.
Use a state diagram when transitions between states explain the concept.
Label nodes and arrows with concrete names and actions.
Keep labels consistent with the pseudocode or code example.
If a diagram becomes crowded, split it into smaller diagrams.
After each smaller diagram, explain it before showing the next diagram.

## Save sources and render images

First, locate the actual project root from the current workspace or project context.
If a project exists, save the `.mmd` source and rendered image under its `docs/explanations` directory.
If no project exists, use the writable session artifact folder supplied by the environment.
If no artifact folder is available, use a writable temporary folder and report its absolute path.
Do not place project diagrams in the global instruction directory.
Use descriptive filenames that identify the topic.
Preserve existing files unless the request updates the same diagram.

Before rendering, run `command -v mmdc`.
If `mmdc` is missing, ask the user to install Mermaid CLI.
Do not install it automatically or invoke `npx` to download it without permission.
Save the `.mmd` source while the renderer is unavailable.
Report the source path and explain that image generation waits for installation.

For inline chat images, prefer PNG output with readable text.
Use `mmdc` to render the source, for example:

```sh
mmdc -i "/absolute/path/topic.mmd" -o "/absolute/path/topic.png" -b white -s 2
```

If the user needs a scalable image, also generate SVG with `mmdc`.
Make sure that rendering succeeds and the output file exists.
Inspect the image when an image-viewing tool is available.
Make sure that labels are readable and no content is clipped.
If parsing fails, use the actual error to repair the source and render it again.
If a sandbox blocks the browser, request the required execution permission instead of changing valid Mermaid syntax.
Keep the source when a browser dependency or environment restriction prevents rendering.
State the failure and link to the source without claiming that an image exists.

## Show the result in the chat

Use the chat image feature when it supports local PNG or SVG files.
In Codex desktop, embed the generated image with its absolute filesystem path:

```markdown
![Diagram description](/absolute/path/topic.png)
```

Do not rely on a Mermaid code fence to show the diagram.
The rendered image is the primary visual.
If SVG does not display, render a PNG from the same `.mmd` source with `mmdc`.
If the chat cannot show the image, provide a clickable file link and its absolute path before the explanation.
Link the `.mmd` source when the user needs to edit or reuse the diagram.
Do not claim that the chat displayed an image unless the interface provides evidence.
After the image or fallback link, give the bullet points that explain the diagram.
