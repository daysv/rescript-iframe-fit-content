@val external window: {..} = "window"
@val external document: {..} = "document"
@val external location: {..} = "location"
@send external toString: 'fn => string = "toString"

type observer
@new external getResizeObserver: 'entries => observer = "ResizeObserver"
@send external observe: (observer, Dom.element) => unit = "observe"
@send external disconnect: observer => unit = "disconnect"

type data = {_type: [#disconnect | #observe]}
type event = {data: data}

let make = () => {
  let sendHeight = (height: float) => {
    window["parent"]["postMessage"](. {
      "_type": #setIframeHeight,
      "height": height,
    })->ignore
    height
  }

  let setHeight = () => {
    let htmlElement = document["documentElement"]
    let bodyElement = document["body"]
    [
      htmlElement["clientHeight"],
      htmlElement["scrollHeight"],
      htmlElement["offsetHeight"],
      bodyElement["scrollHeight"],
      bodyElement["offsetHeight"],
    ]
    ->Js.Math.maxMany_float
    ->sendHeight
  }

  let observer = getResizeObserver(entries => {
    switch entries->Js.Array2.find(val => val["target"] === document["body"]) {
    | Some(_) => Some(setHeight())
    | None => None
    }->ignore
  })

  observer->observe(document["body"])
}

let toString = toString