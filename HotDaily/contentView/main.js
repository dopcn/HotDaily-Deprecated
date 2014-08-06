

function connectWebViewJavascriptBridge(callback) {
                                        if (window.WebViewJavascriptBridge) {
                                            callback(WebViewJavascriptBridge)
                                        } else {
                                            document.addEventListener('WebViewJavascriptBridgeReady', function() {
                                                                      callback(WebViewJavascriptBridge)
                                                                      }, false)
                                        }
}

connectWebViewJavascriptBridge(function(bridge) {
                               bridge.init(function(message){
                                           var jsondata = JSON.parse(message)
                                           $('#content').empty()
                                           window.scroll(0,0)
                                           $('h3').text(jsondata.title)
                                           $('#categoryName').text(jsondata.categoryName)
                                           $('#subtitle').text(jsondata.author + '    ' +jsondata.composeTime.split('.')[0])
                                           var fragment = document.createDocumentFragment(),
                                               list = jsondata.list
                                           for(var x in list){
                                               var div = document.createElement("div")
                                               if (list[x].authorId == jsondata.authorId) {
                                                   div.setAttribute('class','authorReply')
                                               } else {
                                                   div.setAttribute('class','reply')
                                               }
                                               var li2 = document.createElement('p')
                                               li2.appendChild(document.createTextNode(list[x].author + '    ' + list[x].replyTime.split('.')[0]))
                                               div.appendChild(li2)
                                           
                                               var listTr = document.createElement('p')
                                               if (list[x].con.match('[imgstart]')) {
                                                    var node = list[x].con.replace(/\[imgstart].*?\[imgend]/g, function(word){
                                                                          return "<img src=\"" + word.split(";")[1] + "\"/>"
                                                                          })
                                                    listTr.innerHTML = node
                                                    div.appendChild(listTr)
                                                } else {
                                                    listTr.appendChild(document.createTextNode(list[x].con))
                                                    div.appendChild(listTr)
                                                }
                                                fragment.appendChild(div)
                                           }
                                           $('#content').append(fragment)
                                           
                                        })
                               
                               })