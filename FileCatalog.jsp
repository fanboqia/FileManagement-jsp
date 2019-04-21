<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.wisdom.framework.web.common.toolbar.*"%>
<%@ page language="java" import="com.wisdom.framework.web.context.core.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
WsdToolBarInfo toolBarInfo = WsdToolBarContext.getToolBarInfoFromRequest(request);
toolBarInfo.setShowDelete(true);
toolBarInfo.setShowCancel(true);
toolBarInfo.setShowEdit(true);
toolBarInfo.setShowSave(true);
toolBarInfo.setShowUsedAndUnUsed(false);
toolBarInfo.setShowAdd(true);
toolBarInfo.setShowRefresh(true);
toolBarInfo.setShowMainBar(false);
%>
<jsp:include page="/common/wsdTopHTML.jsp" />
<html>
<head>
    <title>文件管理</title>
    <jsp:include page="/common/header.jsp" />
    <script src="${pageContext.request.contextPath}/common/uploadAnddownload/swfupload/swfupload.js" type="text/javascript"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/common/uploadAnddownload/swfupload/swfupload.queue.js" ></script>
    <script>
        document.onkeydown = function () {
            if (window.event && window.event.keyCode == 13) {
                window.event.returnValue = false;
            }
        }
    </script>
    <style>
        .icon-down{
            background: url(${pageContext.request.contextPath}/css/miniIcons/down.png) no-repeat;
        }
        .icon-up{
            background: url(${pageContext.request.contextPath}/css/miniIcons/up.png) no-repeat;
        }
    </style>
</head>
<body style="display:none">
    <div class="wsd-toolbar" id="WsdMainToolBar">
        <table>
            <tr>
                <td style="width:100%;">
                    <jsp:include page="/common/commonBar.jsp" />
                </td>
                <td style="white-space:nowrap;">
                    <jsp:include page="/common/commonOrgBar.jsp" />
                </td>
            </tr>
        </table>
    </div>
    <div>
        <%if(WsdRequestQueryString.getMenuViewSchemeCode(request)==null){%>
        <table id="AreaQuickSearchCustom" style="left:33%;">
            <tr>
                <td style="width:86%;">
                    <input label="全局查询" id="smenuCode" name="udf11" data-options="{opr:'like {$0}'}" class="wsd-textbox" required="required" emptyText="文件名、关键字、目录名"/>
                </td>
                <td><a class="wsd-button" iconcls="icon-search" style="width:40px" onclick="$wfi$.WsdFrameworkInfo.MethodInfo.QuickSearchCustom();" /></td>
                <td><a class="wsd-button" iconcls="icon-remove" style="width:40px" onclick="$wfi$.WsdFrameworkInfo.MethodInfo.ClearQuickSearch();" /></td>
            </tr>
        </table>
        <%}else{%>
        <jsp:include page="/common/commonQuickSearch.jsp" />
        <%}%>
    </div>
    <div class="wsd-fit">
        <div class="wsd-splitter" style="height: 100%;width: 100%" vertical="false">
            <div size="20%" showcollapsebutton="true" style="width:100%;height:100%">
                <a class="wsd-button" iconcls="icon-add" id="_BasicAddRoot" onclick="$wfi$.WsdToolBar.AddRoot">新增根目录</a>
                <a class="wsd-button" iconcls="icon-add" id="_BasicAddChild" onclick="$wfi$.WsdToolBar.AddChild">新增子目录</a>
                <a class="wsd-button" iconcls="icon-cancel" id="_BasicFilter" onclick="$wfi$.clearFilter">取消过滤</a>
                <a class="wsd-button" iconcls="icon-edit" id="_BasicEdit" onclick="$wfi$.onEditNode">编辑</a>
                <a class="wsd-button" iconcls="icon-remove" id="_BasicDelete" onclick="$wfi$.WsdToolBar.js_doctrl_DeleteClientButtonClick">删除</a>
                <a class="wsd-button" iconcls="icon-save" id="_BasicSave" onclick="$wfi$.WsdToolBar.TreeSave">保存</a>
                <a class="wsd-button" iconcls="icon-cancel" id="_BasicCancel" onclick="$wfi$.WsdToolBar.js_doctrl_CancelClientButtonClick">取消</a>
                <ul id="menuTree" class="wsd-tree" beanid='CWMB.FileCatalogRequestBean' method='loadMenu' nodeCanEdit="true" onupdate="$wfi$.drawColor" showTreeIcon="true"
                    showtreeicon="false" textfield="menuName"  height="93%" detailIds="fileGrid" allowCellEdit="true"
                    allowselect="true" expandonload="0" allowdrag="false" allowdrop="true" allowleafdropin="true" ondrop="$wfi$.dropMenuTree"
                    showcheckbox="false" customCurrentChange="$wfi$.menuCurrentChange" onnodedblclick="$wfi$.onEditNode" onnodeclick="$wfi$.onNodeClick">
                </ul>
            </div>
            <div showcollapsebutton="false" style="width:100%;height:100%">
                <div showcollapsebutton="true" style="width:100%;height:100%">
                    <div id="fileGrid" style="width:100%;height:100%;"
                         class="wsd-documentgrid" idfield="id" method="loadFiles" ctx_checkbeforeshowdialog="$wfi$.beforeSelDe" ctx_checkafterclickok="$wfi$.lineAddChange"
                         allowresize="false" pagesize="20" uploadlinkholderid="a5" onrowclick="$wfi$.buttonControl"
                         allowcellselect="true" showuploadbtn="true" selectonload="false"
                         operatemode="1" showpager="false" editdetailid="fileGrid" onload="$wfi$.detailLoaded"
                         showcmdbar="true" showcopyaddbtn="false" multiselect="true" isAsEdit="true" ondrawcell ="$wfi$.prevDoc"
                         showclearbtn="true" showaddbtn="false" showtoolbar="true" customUploadComplete="$wfi$.customUploadComplete"
                         propertyinmaster="documents">
                        <div property="toolbar" style="float:left;display:inline-flex;">
                            <div>
                                <table>
                                    <tr>
                                        <td>
                                            <span id="a5">
                                                <a id="bactchUpload" class="wsd-grid-a wsd-batchupload"> <span>上传</span></a>
                                            </span>
                                            <span>
                                                <a id="docSave" class="wsd-grid-a icon-save"> <span>保存</span></a>
                                            </span>
                                            <span>
                                                <a class="wsd-grid-a icon-up" id="buttonUp">向上移动</a>
                                            </span>
                                            <span>
                                                <a class="wsd-grid-a icon-down" id="buttonDown">向下移动</a>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div property="columns">
                            <div type="checkcolumn" width="40" allowsort="false"></div>
                            <div field="udf1" headeralign="center" align="center" width="80" allowsort="true">序号</div>
                            <div field="udf2"  width="100" name="keyword" align="center" headeralign="center" vtype="required" allowsort="true">
                                关键词
                                <input property="editor" class="wsd-textbox" name="udf2" align="center">
                            </div>
                            <div field="documentName" width="400" headeralign="center"align="center" allowsort="true" allowsort="false">
                                文件名
                                <input property="editor" class="wsd-textbox" name="documentName" align="center">
                            </div>
                            <div field="createdDate" width="100" headeralign="center"
                                 allowsort="true" align="center" dateformat="yyyy-MM-dd" allowsort="false">上传时间</div>
                            <div field="udf3" displayfield="udf4" width="95" align="center" headeralign="center">
                                保管期限
                                <input property="editor" id="validPeriod" name="udf3" textname="udf4" class="wsd-combobox" codeclass="VALID_PERIOD">
                            </div>
                            <div width="100" headeralign="center" align="center"
                                 allowsort="true" linkcol="true" allowsort="false">预览</div>
                            <div name="id" width="100" headeralign="center" align="center"
                                 allowsort="true" linkcol="true" allowsort="false">下载</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function PageFunction() {
            $wfi$.WsdFrameworkInfo.App.MainBeanId = "CWMB.FileCatalogRequestBean";
            $wfi$.WsdFrameworkInfo.DataControlContext.IEntityCurrentChangeMain = "menuTree";
            $wfi$.WsdFrameworkInfo.DataControlContext.IEntityCurrentChangeControlBarStatus = "menuTree";
            $wfi$.WsdFrameworkInfo.DataControlContext.IEntityCurrentChangeWhenOprSuccess = "menuTree";

            //上个菜单名称，取消操作用
            $wfi$.lastEditMenuName = "";
            //当前查询条件
            $wfi$.curSearch = "";
            $wfi$.editInput = null;

            //浏览状态
            $wfi$.viewStatus = function(){
                $wfi$.setAllToolBarStatus(true);
                mini.get("_BasicCancel").setEnabled(false);
                mini.get("_BasicSave").setEnabled(false);
            }

            //编辑状态
            $wfi$.editStatus = function(){
                $wfi$.setAllToolBarStatus(false);
                mini.get("_BasicCancel").setEnabled(true);
                mini.get("_BasicSave").setEnabled(true);
                mini.get("menuTree").setIsWsdEditing(true);
                mini.get("menuTree").doEditStatus();
            }

            //按钮状态设置
            $wfi$.setAllToolBarStatus = function(status){
                var bars = ["_BasicAddChild","_BasicAddRoot","_BasicEdit","_BasicCancel","_BasicSave","_BasicDelete"];
                for(var i = 0; i < bars.length; i++){
                    mini.get(bars[i]).setEnabled(status);
                }
            }

            //编辑节点
            $wfi$.onEditNode = function(){
                $wfi$.editStatus();
                var tree = mini.get("menuTree");
                var node = tree.getSelectedNode();
                tree.beginEditRow(node);
                setTimeout(function(){
                    var input = document.getElementById(tree._id+"$edit$"+node._id);
                    $(input).unbind("blur");
                    $wfi$.editInput = input;
                    $wfi$.lastEditMenuName = node.menuName;
                },101);
            }

            //保存树节点
            $wfi$.WsdToolBar.TreeSave = function(){
                $wfi$.WsdToolBar.js_doctrl_SaveClientButtonClick();
            }

            //保存之后
            $wfi$.WsdFrameworkInfo.CustomMethods.AfterSave = function(result){
                if(result.oprSuccess){
                    $wfi$.viewStatus();
                    var tree = mini.get("menuTree");
                    var node = tree.getSelectedNode();
                    $wfi$.lastEditMenuName = node.menuName;
                    node.menuName = $wfi$.editInput.value;
                    tree.updateNode(node,node);
                    tree.commitEdit();
                }
            };

            //取消按钮
            $wfi$.WsdFrameworkInfo.CustomMethods.WhenCancel =function(sender, args){
                mini.get("fileGrid").setIsWsdEditing(true);
                mini.get("fileGrid").doEditStatus();
                $wfi$.viewStatus();

                var tree =  mini.get("menuTree");
                var cur = tree.getSelected();
                //新增
                var isAdd = cur.id == undefined ? true : false;
                if(isAdd){
                    tree.removeNode(cur);
                //编辑
                }else{
                    cur.menuName = $wfi$.lastEditMenuName;
                    tree.updateNode(cur,cur);
                    tree.cancelEdit();
                }
            }

            //增加根目录节点
            $wfi$.WsdToolBar.AddRoot = function(sender,args){
                var menuTree = mini.get("menuTree");
                menuTree.deselectAll(false);
                var newNode = {};
                newNode.menuName = "目录名";
                menuTree.addNode(newNode, "add", null);
                menuTree.setSelected(newNode);
                $wfi$.onEditNode();
                genWsdOperate(newNode);
                genMenuNameTreePath(newNode,newNode.menuName);
            }

            //增加子节点
            $wfi$.WsdToolBar.AddChild = function(sender,args){
                var tree = mini.get("menuTree");
                var node = tree.getSelectedNode();
                tree.expandNode(node);
                var newNode = {};
                newNode.menuName = "目录名";
                tree.addNode(newNode, "add", node);
                tree.setSelected(newNode);
                $wfi$.onEditNode();
                genWsdOperate(newNode);
                genMenuNameTreePath(newNode,newNode.menuName);
            }

            $wfi$.WsdFrameworkInfo.CustomMethods.CustomControlBarStatus = function (entity) {

            }

            $wfi$.WsdFrameworkInfo.CustomMethods.AfterParse = function() {
                mini.get("fileGrid").setIsWsdEditing(true);
                mini.get("fileGrid").doEditStatus();
                $wfi$.viewStatus();
                $("#docSave").click(function(){
                    $wfi$.WsdToolBar.js_doctrl_SaveClientButtonClick();
                });
                $("#buttonUp").click(function(){
                    $wfi$.WsdToolBar.FileSrlUp();
                });
                $("#buttonDown").click(function(){
                    $wfi$.WsdToolBar.FileSrlDown();
                });
                mini.get("_BasicSelectOrg").hide();
                mini.get("_BasicSelectBizOrg").hide();
            }

            //重写文件目录树删除方法
            $wfi$.WsdToolBar.js_doctrl_DeleteClientButtonClick = function (sender, args) {
                var oprCtrl = mini.get($wfi$.WsdFrameworkInfo.DataControlContext.IEntityCurrentChangeWhenOprSuccess);
                var datas = oprCtrl.getSelecteds();
                mini.confirm($wfi$.WsdFrameworkInfo.DeleteMessage, null, function (args) {
                    if (args == "ok") {
                        $wfi$.WsdFrameworkInfo.AjaxRequest({
                            method: 'treeDelete',
                            pd: datas,
                            loadingTitle: "正在删除",
                            sfnc: function (ctxObj, result) {
                                if (result.oprSuccess) {
                                    var rows = datas;
                                    if (rows != null && rows.length > 0) {
                                        oprCtrl.removeObjs(rows);
                                        if (oprCtrl.getTotalCount) {
                                            var rowsCount = oprCtrl.getTotalCount();
                                            oprCtrl.setTotalCount(rowsCount - rows.length);
                                        }
                                    }
                                }
                            }
                        });
                    }
                });
            }

            $wfi$.WsdFrameworkInfo.Init();

            //新增时增加节点
            $wfi$.WsdFrameworkInfo.CustomMethods.WhenAdd = function (sender) {

            }

            //生成menuCode
            function genMenuCode(){
                return $wfi$.WsdUtils.DateToString(new Date(),"yyyyMMddHHmmss")+"-"+Math.floor(Math.random()*100+1);
            }

            //生成treePath,treePathName
            function genMenuNameTreePath(cur,menuName){
                var tree = mini.get("menuTree");
                var isAdd = cur.id == undefined ? true : false;
                var parentNode = tree.getParentNode(cur);
                //菜单名称更新
                cur.menuName = menuName;
                if (isAdd) {
                    cur.menuCode = genMenuCode();
                }
                //当前节点为父节点
                if(parentNode == undefined || parentNode.menuCode == undefined){
                    if(isAdd){
                        cur.treePath = cur.menuCode;
                        cur.treePathName = cur.menuName;
                    }else{
                        cur.treePathName = cur.menuName;
                    }
                }else{
                    if(isAdd){
                        cur.treePath = parentNode.treePath+"|"+cur.menuCode;
                        cur.treePathName = parentNode.treePathName+"|"+cur.menuName;
                    }else{
                        cur.treePathName = parentNode.treePathName+"|"+cur.menuName;
                    }
                }
            }

            //生成编辑，新增操作符
            function genWsdOperate(cur){
                if(cur.id == undefined){
                    cur.wsdOperate = $wfi$.WsdFrameworkInfo.operate.opradd;
                }else{
                    cur.wsdOperate = $wfi$.WsdFrameworkInfo.operate.opredit;
                }
            }

            //保存时将从表保存进主表字段中
            $wfi$.WsdToolBar.CheckInputWhenSaveEntity = function() {
                //提交从表编辑数据
                var grid = mini.get("fileGrid");
                grid.commitEdit();
                var tree = mini.get("menuTree");
                tree.commitEdit();
                var cur = tree.getSelected();
                genWsdOperate(cur);
                //添加默认文件序号
                var data = grid.data;
                for(var i = 0; i < data.length; i++){
                    data[i].udf1 = i;
                }
                cur.documents = data;
                return true;
            }

            $wfi$.WsdFrameworkInfo.CustomMethods.WhenEdit = function(sender,args) {
            }

            //文件向上移动
            $wfi$.WsdToolBar.FileSrlUp = function(){
                var grid = mini.get("fileGrid");
                moveRow(grid,grid.getSelected(),-1);
            }

            //文件向下移动
            $wfi$.WsdToolBar.FileSrlDown = function(){
                var grid = mini.get("fileGrid");
                moveRow(grid,grid.getSelected(),1);
            }

            //移动行
            function moveRow(grid,row,offset){
                var data = grid.data;
                var index = grid.indexOf(row);
                if(index+offset < 0){
                    swap(grid,data,data.length-1,0,updateSrl);
                    return;
                }
                if(index+offset >= data.length){
                    swap(grid,data,0,data.length-1,updateSrl);
                    return;
                }
                swap(grid,data,index+offset,index,updateSrl);
                console.log(data);
            }

            //行交换
            function swap(grid,data,index1,index2,callback){
                var temp = data[index1];
                data[index1] = data[index2];
                data[index2] = temp;
                if(callback != undefined && typeof callback === "function"){
                    callback(data,index1,index2);
                }
                grid.setData(data);
                grid.setSelected(data[index1]);
                grid.beginEditRow(grid.getSelected());
            }

            //修改序号
            function updateSrl(data,index1,index2){
                for(var i = 0 ; i < data.length; i++){
                    data[i].udf1 = i;
                }
            }

            //从表按钮控制
            $wfi$.buttonControl = function(){

            }

            //自定义查询
            $wfi$.WsdFrameworkInfo.MethodInfo.QuickSearchCustom = function(){
                var oprCtrl = $wfi$.WsdFrameworkInfo.MethodInfo.GetWsdFormFromPanel("AreaQuickSearchCustom");
                oprCtrl.validate();
                if (!oprCtrl.isValid()) {
                    mini.alert("请输入必填项！");
                    return false;
                }
                //获取当前选中菜单
                var tree = mini.get("menuTree");
                var node = tree.getSelectedNode() || {};

                //获取查询条件
                var menu = $wfi$.WsdFrameworkInfo.MethodInfo.GetPanelData("AreaQuickSearchCustom");
                node.udf11 = menu.udf11;
                $wfi$.curSearch = node.udf11;

                $wfi$.WsdFrameworkInfo.AjaxRequest({
                    method: 'menuSearch',
                    pd: node,
                    sfnc: function (ctxObj, result) {
                        if (result != null && result.data != null) {
                            //标红并且自动展开
                            var menus = result.data;
                            $wfi$.queryMenus = menus;
                            $wfi$.isLoadFromDetail = true;
                            if(menus.length == 0){return false;}
                            //获取所有查找到的菜单
                            var nodeMap = {};
                            for(var i = 0; i < menus.length; i++){
                                nodeMap[menus[i].id] = menus[i];
                            }
                            var nodes = tree.findNodes(function(node){
                                if(nodeMap[node.id] != undefined) return true;
                            });
                            tree.expandAll();
                            $wfi$.colorizeMenu(nodes);
                            if(nodes.length > 0){
                                tree.selectNode(nodes[0]);
                            }
                        }
                    }
                });
            }

            //查询出来的菜单信息
            $wfi$.queryMenus = [];
            $wfi$.isClientClick = false;

            $wfi$.menuCurrentChange = function(){
                $wfi$.isClientClick = false;
                return true;
            }

            //节点点击
            $wfi$.onNodeClick = function(){
                $wfi$.isClientClick = true;
                return true;
            }

            //从表加载
            $wfi$.detailLoaded = function(){
                if($wfi$.isClientClick){return true;}
                mini.get("fileGrid").setIsWsdEditing(true);
                mini.get("fileGrid").doEditStatus();
                var grid = mini.get("fileGrid");
                var menus = $wfi$.queryMenus;
                if(menus.length == 0){return false;}
                //默认选择第一个菜单的文件
                var docs = menus[0].documents;
                var docMap = {};
                for(var i = 0; i < docs.length; i++){
                    docMap[docs[i].id] = docs[i];
                }
                //获取所有菜单下的行
                var rows = grid.findRows(function(row){
                    if(docMap[row.id] != undefined) return true;
                });
                if(rows.length > 0){
                    //grid.setSelected(rows[0]);
                }
                $wfi$.colorizeGrid();
                return true;
            }

            //获取Node通过菜单编号
            $wfi$.getNodesByMenuCodes = function(tree,menus){
                var nodeMap = {};
                for(var i = 1; i < menus.length; i++){
                    nodeMap[menus[i]] = menus[i];
                }
                var nodes = tree.findNodes(function(node){
                    if(nodeMap[node.menuCode] != undefined) return true;
                });
                return nodes;
            }

            //获取node DOM元素
            $wfi$.getNodeDom = function(tree,nodes){
                var doms = [];
                for(var i = 0; i < nodes.length; i++){
                    doms.push(tree.getCellEl(nodes[i],0));
                }
                return doms;
            }

            //显示匹配的数据表格菜单路径
            $wfi$.showMenuPath = function(nodes){
                var tree = mini.get("menuTree");
                var menuCodeMap = {};
                for(var i = 0; i < nodes.length; i++){
                    var treepath = nodes[i].treePath;
                    var menus = treepath.split("|");
                    for(var j = 0; j < menus.length; j++){
                        menuCodeMap[menus[j]] = menus[j];
                    }
                    //废除颜色标记path方案
                    //var nodesShow = $wfi$.getNodesByMenuCodes(tree,menus);
                    //var nodes_dom = $wfi$.getNodeDom(tree,nodesShow);
                    //$(nodes_dom).find(".mini-tree-nodeshow").css({"background":"#666666"});
                    //$(nodes_dom).find(".mini-tree-nodetext").css({"color":"#fff"});
                }
                tree.filter(function (node) {
                    return menuCodeMap[node.menuCode] == node.menuCode;
                });
            }

            //给树结构重绘更新后上色
            $wfi$.drawColor = function(e){
                //hoverCRUD();
                //初始化颜色
                $("#menuTree .mini-tree-nodetext").css({"color":"#666666"});
                $("#menuTree .mini-tree-nodetext").each(function(index,cell){
                    //$wfi$.tagMatchString(cell,$wfi$.curSearch);
                    $wfi$.tagMatchChar(cell,$wfi$.curSearch);
                });
            }

            //给全局查询到的匹配字段标红->菜单
            $wfi$.colorizeMenu = function(nodes){
                $wfi$.showMenuPath(nodes);

            }

            //给全局查询到的匹配字段标红->数据表格
            $wfi$.colorizeGrid = function(){
                //初始化颜色
                $("#fileGrid .mini-grid-cell-inner").css({"color":"#666666"});
                $("#fileGrid .mini-grid-cell-inner").each(function(index,cell){
                    //bug这里匹配要防止checkbox,下载预览的HTML代码被替换,所以过滤
                    if(cell.outerHTML.includes("checkbox") || cell.outerHTML.includes("下载") || cell.outerHTML.includes("预览")){
                        return true;
                    }
                    $wfi$.tagMatchChar(cell,$wfi$.curSearch);
                });
            }

            //HTML全标红
            $wfi$.tagMatchString = function(cell,key){
                //includes为ES6新函数
                if($(cell).html().includes(key)){
                    $(cell).css({"color":"crimson","font-weight":"bold"});
                }
            }

            //HTML部分匹配标红
            $wfi$.tagMatchChar = function(cell,key){
                var text = $(cell).html();
                var startIndex = text.indexOf(key);
                var endIndex = startIndex+key.length;
                if(startIndex > -1){
                    var chars = text.split("");
                    var texts = "";
                    for(var i = 0 ; i < chars.length; i++){
                        if(i >= startIndex && i < endIndex){
                            texts += "<span style='color:crimson;font-weight:bold'>"+chars[i]+"</span>";
                        }else{
                            texts += "<span>"+chars[i]+"</span>";
                        }
                    }
                    $(cell).html(texts);
                }
            }

            //上传完成后更新序号
            $wfi$.customUploadComplete = function(e){
                var grid = mini.get("fileGrid");
                var data = grid.data;
                e[0].udf1 = data.length;
                grid.appendGridData(e);
                return true;
            }

            //预览文档
            $wfi$.prevDoc = function(sender){
                if(sender.column.header=="预览"){
                    sender.cellHtml = "<a href=\"javascript:void(0);\" onclick=\$wfi$.preview();\><font color=\"blue\">预览</font></a>";

                }
            };

            $wfi$.preview = function(){
                var grid = mini.get("fileGrid").getSelected();
                WsdDownLoadButton.DownLoadMethod(grid.id,null,true);
            }

            //清除过滤
            $wfi$.clearFilter = function(){
                mini.get("menuTree").clearFilter();
            }

            //鼠标放上去展示CRUD
             function hoverCRUD(){
                var addIcon = "<span class='crud mini-button-icon mini-icon mini-iconfont icon-add' style='position:relative;top:5px;width:100px;' onclick='$wfi$.WsdToolBar.AddChild()'></span>";
                var editIcon = "<span class='crud mini-button-icon mini-icon mini-iconfont icon-edit' style='position:relative;top:5px;' onclick='$wfi$.onEditNode()'></span>";
                $("#menuTree .mini-tree-nodeshow").hover(function(e){
                    $(this).append(addIcon);
                    $(this).append(editIcon);
                },function(e){
                    $(this).children().remove(".crud");
                });
            }

        }
    </script>
</body>
</html>
