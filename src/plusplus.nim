import
  options,
  macros,
  std / marshal,
  std / httpcore


when defined(js):
  import
    std / dom

  export
    dom,
    httpcore

else:
  import
    asyncdispatch

  import
    httpbeast,
    karax / [karaxdsl, vdom]

  export
    karaxdsl,
    vdom,
    httpcore,
    httpbeast

when defined(js):
  discard
else:
  #
  # the following are to help C instantiate HTML on events
  #
  template kxi*(): int = 0
  template addEventHandler*(n: VNode; k: EventKind; action: string; kxi: int) =
    n.setAttr($k, action)
  template addEventHandler*(n: VNode; k: EventKind; action: proc; kxi: int) =
    n.setAttr($k, action())
  #
  # vars for the API methods
  #



# Call
#   Ident "body"
#   ExprEqExpr
#     Ident "onload"
#     Ident "getInventory



macro PAGE*(content: untyped): untyped =
  when defined(js):
    discard
  else:
    when defined(htmlfilename):
      when defined(jsfilename):
        const htmlfilename {.strdefine.}: string = ""
        const jsfilename {.strdefine.}: string = ""
        # echo "BLOCK=" & treeRepr(content)
        var pageHead = newNimNode(nnkStmtList)
        var pageBody = newNimNode(nnkStmtList)
        for statement in content:
          if statement.kind != nnkCall and statement.kind != nnkCommand:
            error("just under PAGE:, expecting a 'body:' section and optionally a `head:` section")
          let rootSection = statement[0]
          # HEAD
          if eqIdent(rootSection, "head"):
            pageHead = statement
            pageHead[1].add quote do:
              script( src=jsfilename )
          # BODY
          if eqIdent(rootSection, "body"):
            # echo "BODY=" & treeRepr(statement)
            pageBody = statement
        #
        result = quote do:
          var v = buildHtml(html):
            `pageHead`
            `pageBody`
          var htmlContent = $v
          writeFile(htmlfileName, htmlContent)
          echo htmlfileName & " file done with " & jsfilename & " referenced"
        # echo "RESULT = " & treeRepr(result)
      else:
        echo "FAIL: COMPILER jsfilename COMMAND MISSING"
    else:
      echo "FAIL: COMPILER htmlfilename COMMAND MISSING"

macro JS*(content: untyped): untyped =
  when defined(js):
    `content`
  else:
    discard

macro CALLABLE*(content: untyped): untyped =
  when defined(js):
    `content`
  else:
    # echo "CALLABLE=" & treeRepr(content)
    let procDef = content[0]
    if procDef.kind != nnkProcDef:
      error("A CALLABLE block must contain one proc and nothing else")
    let name = procDef[0]
    let nameStr = $name
    echo "NAME=" & nameStr
    result = quote do:
      proc `name`(): string = `nameStr` & "()"

macro ROUTE*(routeMethod: HttpMethod, route: string, content: untyped): untyped =
  # echo "R KIND=" & treeRepr(route)
  echo "ROUTE=" & treeRepr(content)
  if route.kind notin {nnkStrLit..nnkTripleStrLit, nnkSym}:
    error "ROUTE's route must be a string literal; recommend using PATH "
  let routeString = $route
  when defined(js):
    # `content`
    discard
  else:
    let procDef = content[0]
    if procDef.kind != nnkProcDef:
      error("A CALLABLE block must contain one proc and nothing else")
    #
    var nameNode = procDef[0]
    if nameNode.kind == nnkPostFix: # is there a name* postfix?
      nameNode = nameNode[1];       # move to the right child if so
    let nameStr = $nameNode
    let outerName = "outerjson_" & nameStr
    let outerNameNode = newIdentNode(outerName)
    echo "OUTER NAME=" & nameStr
    #
    let returnTypeNode = procDef[3]
    var returnTypeIdent = procDef[3]
    if returnTypeNode.kind == nnkFormalParams:
      returnTypeIdent = returnTypeNode[0]
    else:
      error "ROUTE can't handle a missing return type...yet (TODO)"
    #
    #proc `outerNameNode`(): `returnTypeIdent`:
    result = quote do:
      `content`
      proc `outerNameNode`(): string =
        let temp = `nameNode`()
        result = $$temp

macro SERVER*(): untyped =
  result = quote do:
    proc onRequest(req: Request): Future[void] =
      if req.httpMethod == some(HttpGet):
        case req.path.get()
        of "/":
          let answer = outerjson_getInventory()
          req.send(answer)
        else:
          req.send(Http404)
    run(onRequest)



#
# LISTY THINGS
#

macro ID*(content: untyped): untyped =
  result = newNimNode(nnkStmtList)
  for statement in content:
    # echo treeRepr(statement)
    if statement.kind == nnkAsgn:
      let idName = statement[0]
      let idStringLiteral = statement[1]
      result.add quote do:
        const `idName` = `idStringLiteral`
    else:
      error("ERROR: an ID statement list is in the form of name = \"string\" ")

macro PATH*(content: untyped): untyped =
  result = newNimNode(nnkStmtList)
  for statement in content:
    # echo treeRepr(statement)
    if statement.kind == nnkAsgn:
      let pathName = statement[0]
      let pathStringLiteral = statement[1]
      result.add quote do:
        const `pathName` = `pathStringLiteral`
    else:
      error("ERROR: an ID statement list is in the form of name = \"string\" ")
