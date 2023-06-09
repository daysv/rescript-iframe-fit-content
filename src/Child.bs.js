// Generated by ReScript, PLEASE EDIT WITH CARE


function make(param) {
  var setHeight = function (param) {
    var htmlElement = document.documentElement;
    var bodyElement = document.body;
    var height = Math.max(htmlElement.clientHeight, htmlElement.scrollHeight, htmlElement.offsetHeight, bodyElement.scrollHeight, bodyElement.offsetHeight);
    window.parent.postMessage({
          type: "setIframeHeight",
          height: height
        });
    return height;
  };
  var observer = new ResizeObserver((function (entries) {
          var match = entries.find(function (val) {
                return val.target === document.body;
              });
          if (match !== undefined) {
            setHeight(undefined);
          }
          
        }));
  observer.observe(document.body);
}

function toString(prim) {
  return prim.toString();
}

export {
  make ,
  toString ,
}
/* No side effect */
