# ReScript Iframe Fit Content

Automatically set the height of the iframe based on the content.

## Installation

```sh
npm install rescript-iframe-fit-content
```

Then add `rescript-iframe-fit-content` to bs-dependencies in your bsconfig.json. A minimal example:

```json
{
  "name": "my-thing",
  "sources": "src",
  "bs-dependencies": ["rescript-iframe-fit-content"]
}
```


## Usage

### ReScript

```rescript
iframeElement -> IframeFitContent.make
```

### JavaScript

```js
import * as IframeFitContent from 'rescript-iframe-fit-content'
const iframe = document.getElementById("iframe")
IframeFitContent.make(iframe)
```

See the examples folder.


