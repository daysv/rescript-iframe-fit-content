type contentWindow
@get external getContentWindow: Dom.htmlIframeElement => contentWindow = "contentWindow"
@get external getDocument: contentWindow => Dom.document = "document"

type script
@send external createElement: (Dom.document, string) => Dom.element = "createElement"
@set external textContent: (Dom.element, string) => unit = "textContent"
@get external getHtmlBodyElement: Dom.document => Dom.htmlBodyElement = "body"
@send external appendChild: (Dom.htmlBodyElement, Dom.element) => unit = "appendChild"

@scope("location") external locationOrigin: string = "origin"

@set external setIframeHeight: (Dom.htmlIframeElement, string) => unit = "height"

type data = {
  _type: [#setIframeHeight],
  height: float,
}
type message = {
  data: data,
  origin: string,
}

@scope("window") @val
external addWindowEventListener: (string, message => unit) => unit = "addEventListener"
@scope("window") @val
external removeWindowEventListener: (string, message => unit) => unit = "removeEventListener"

let createScript = (document: Dom.document) => {
  document->createElement("script")
}

let listener = (iframe: Dom.htmlIframeElement) => {
  ({data, origin}) => {
    if origin === locationOrigin {
      iframe->setIframeHeight(data.height->Js.Float.toString ++ "px")
    }
  }
}

let start = (iframe: Dom.htmlIframeElement) => {
  addWindowEventListener("message", iframe->listener)
}

let stop = (iframe: Dom.htmlIframeElement) => {
  removeWindowEventListener("message", iframe->listener)
}

let make = (iframe: Dom.htmlIframeElement) => {
  let contentWindow = iframe->getContentWindow
  iframe->start

  let document = contentWindow->getDocument
  let script = document->createScript
  script->textContent(`;(${Child.make->Child.toString})();`)
  document->getHtmlBodyElement->appendChild(script)
  iframe
}