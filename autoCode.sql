/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.1.73-community : Database - auto_code
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`auto_code` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `auto_code`;

/*Table structure for table `back_user` */

DROP TABLE IF EXISTS `back_user`;

CREATE TABLE `back_user` (
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `add_time` datetime NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `back_user` */

insert  into `back_user`(`username`,`password`,`add_time`) values ('aaaa','123456','2015-01-05 11:52:26'),('admin','admin','2014-06-24 10:12:49');

/*Table structure for table `datasource_config` */

DROP TABLE IF EXISTS `datasource_config`;

CREATE TABLE `datasource_config` (
  `dc_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `driver_class` varchar(50) DEFAULT NULL,
  `jdbc_url` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `back_user` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`dc_id`),
  KEY `f_username_user` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `datasource_config` */

insert  into `datasource_config`(`dc_id`,`name`,`driver_class`,`jdbc_url`,`username`,`password`,`back_user`) values (4,'aaa','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/auto_code','root','root','admin'),(5,'ISP','net.sourceforge.jtds.jdbc.Driver','jdbc:jtds:sqlserver://192.168.9.31:1433;databaseName=isp','sa','isp#123','admin'),(6,'rms','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/rms','root','root','admin');

/*Table structure for table `template_config` */

DROP TABLE IF EXISTS `template_config`;

CREATE TABLE `template_config` (
  `tc_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `save_path` varchar(100) DEFAULT NULL,
  `content` text,
  `back_user` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`tc_id`),
  KEY `f_backuser` (`back_user`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `template_config` */

insert  into `template_config`(`tc_id`,`name`,`save_path`,`content`,`back_user`) values (8,'durc_Entity',NULL,'package ${context.packageName}.entity;\r\n\r\n\r\npublic class ${context.javaBeanName} {\r\n#foreach($column in $columns) \r\n	private ${column.javaType} ${column.javaFieldName};\r\n#end\r\n\r\n#foreach(${column} in ${columns}) \r\n	public void set${column.javaFieldNameUF}(${column.javaType} ${column.javaFieldName}){\r\n		this.${column.javaFieldName} = ${column.javaFieldName};\r\n	}\r\n\r\n	public ${column.javaType} get${column.javaFieldNameUF}(){\r\n		return this.${column.javaFieldName};\r\n	}\r\n\r\n#end\r\n}','admin'),(9,'durc_DAO',NULL,'package ${context.packageName}.dao;\r\n\r\nimport org.durcframework.core.dao.BaseDao;\r\nimport ${context.packageName}.entity.${context.javaBeanName};\r\n\r\npublic interface ${context.javaBeanName}Dao extends BaseDao<${context.javaBeanName}> {\r\n}','admin'),(10,'durc_Service',NULL,'package ${context.packageName}.service;\r\n\r\nimport org.durcframework.core.service.CrudService;\r\nimport ${context.packageName}.dao.${context.javaBeanName}Dao;\r\nimport ${context.packageName}.entity.${context.javaBeanName};\r\nimport org.springframework.stereotype.Service;\r\n\r\n@Service\r\npublic class ${context.javaBeanName}Service extends CrudService<${context.javaBeanName}, ${context.javaBeanName}Dao> {\r\n\r\n}','admin'),(11,'durc_SearchEntity',NULL,'package ${context.packageName}.entity;\r\n\r\nimport java.util.Date;\r\n\r\nimport org.durcframework.entity.SearchEntity;\r\nimport org.durcframework.core.expression.annotation.ValueField;\r\n\r\npublic class ${context.javaBeanName}Sch extends SearchEntity{\r\n\r\n#foreach($column in $columns) \r\n    private ${column.javaTypeBox} ${column.javaFieldName}Sch;\r\n#end\r\n\r\n#foreach(${column} in ${columns}) \r\n    public void set${column.javaFieldNameUF}Sch(${column.javaTypeBox} ${column.javaFieldName}Sch){\r\n        this.${column.javaFieldName}Sch = ${column.javaFieldName}Sch;\r\n    }\r\n    \r\n    @ValueField(column = \"${column.columnName}\")\r\n    public ${column.javaTypeBox} get${column.javaFieldNameUF}Sch(){\r\n        return this.${column.javaFieldName}Sch;\r\n    }\r\n\r\n#end\r\n\r\n}','admin'),(12,'durc_Mybatis',NULL,'<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n<!DOCTYPE  mapper PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\" \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\" >\r\n<mapper namespace=\"${context.packageName}.dao.${context.javaBeanName}Dao\">\r\n    <resultMap id=\"queryResultMap\" type=\"${context.packageName}.entity.${context.javaBeanName}\">\r\n        #foreach($column in $columns)\r\n        <result column=\"${column.columnName}\" property=\"${column.javaFieldName}\" jdbcType=\"${column.mybatisJdbcType}\" />\r\n        #end\r\n    </resultMap>\r\n\r\n    <select id=\"find\" parameterType=\"org.durcframework.core.expression.ExpressionQuery\"\r\n		resultMap=\"queryResultMap\">\r\n		SELECT t.*\r\n		FROM ${table.tableName} t\r\n		<include refid=\"expressionBlock.where\" />\r\n		<choose>\r\n			<when test=\"sortname == null\">\r\n				ORDER BY t.${context.pkName} desc\r\n			</when>\r\n			<otherwise>\r\n				ORDER BY ${order}\r\n			</otherwise>\r\n		</choose>\r\n		<if test=\"!isQueryAll\">\r\n			LIMIT\r\n			#{start,jdbcType=INTEGER},#{limit,jdbcType=INTEGER}\r\n		</if>\r\n	</select>\r\n\r\n\r\n    <select id=\"findTotalCount\" parameterType=\"org.durcframework.core.expression.ExpressionQuery\"\r\n		resultType=\"java.lang.Integer\">\r\n		SELECT count(*) FROM ${table.tableName} t\r\n		<include refid=\"expressionBlock.where\" />\r\n    </select>\r\n\r\n    <insert id=\"save\" parameterType=\"${context.packageName}.entity.${context.javaBeanName}\"\r\n#if(${pkColumn.isIdentity})\r\n    keyProperty=\"${context.javaPkName}\" keyColumn=\"${context.pkName}\" useGeneratedKeys=\"true\"\r\n#end\r\n    >\r\n	INSERT INTO ${table.tableName}\r\n         (\r\n #set ($i=0) \r\n        #foreach($column in $columns) \r\n            #if(!${column.isIdentityPk})               \r\n        #if($i > 0),#end `${column.columnName}`\r\n               #set($i=$i+1)\r\n            #end          \r\n        #end\r\n          )\r\n	VALUES (\r\n        #set ($i=0) \r\n        #foreach($column in $columns) \r\n            #if(!${column.isIdentityPk})               \r\n        #if($i > 0),#end #{${column.javaFieldName},jdbcType=${column.mybatisJdbcType}}\r\n               #set($i=$i+1)\r\n            #end          \r\n        #end\r\n \r\n        )\r\n	</insert>\r\n\r\n\r\n    <update id=\"update\" parameterType=\"${context.packageName}.entity.${context.javaBeanName}\">\r\n    UPDATE ${table.tableName}\r\n    SET \r\n#set ($i=0) \r\n        #foreach($column in $columns) \r\n            #if(!${column.isPk})               \r\n        #if($i > 0),#end ${column.columnName}=#{${column.javaFieldName},jdbcType=${column.mybatisJdbcType}}\r\n               #set($i=$i+1)\r\n            #end          \r\n        #end	\r\n    WHERE ${context.pkName} = #{${context.javaPkName},jdbcType=${context.mybatisPkType}}\r\n    </update>\r\n\r\n    <select id=\"get\" resultMap=\"queryResultMap\" parameterType=\"${context.packageName}.entity.${context.javaBeanName}\">\r\n		SELECT t.*\r\n		FROM ${table.tableName} t\r\n		WHERE ${context.pkName} = #{${context.javaPkName},jdbcType=${context.mybatisPkType}}\r\n	</select>\r\n	\r\n	<delete id=\"del\" parameterType=\"${context.packageName}.entity.${context.javaBeanName}\">\r\n		DELETE FROM ${table.tableName}\r\n		WHERE ${context.pkName} = #{${context.javaPkName},jdbcType=${context.mybatisPkType}}\r\n	</delete>\r\n\r\n</mapper>','admin'),(13,'durc_jspPage',NULL,'<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\"\r\n    pageEncoding=\"UTF-8\"%>\r\n<%@ include file=\"../taglib.jsp\" %>\r\n<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n<html>\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n<title>${table.tableName}</title>\r\n<style type=\"text/css\">\r\n.fm_lab{text-align: right;padding:10px;}\r\n</style>\r\n</head>\r\n<body>\r\n	 <div id=\"toolbar\">\r\n		<a href=\"#\" class=\"easyui-linkbutton\" iconCls=\"icon-add\" plain=\"true\" onclick=\"crud.add()\">添加</a>\r\n	</div>\r\n	<table id=\"dg\"></table>\r\n	\r\n	<div id=\"dlg\" class=\"easyui-dialog\" style=\"width:520px;height:380px;padding:10px 20px\"\r\n			closed=\"true\" modal=\"true\" buttons=\"#dlg-buttons\">\r\n		<form id=\"fm\" method=\"post\">\r\n			<table>\r\n#foreach($column in $columns)\r\n    #if(!${column.isIdentityPk})\r\n        <tr>\r\n            <td class=\"fm_lab\">${column.javaFieldName}:</td><td><input name=\"${column.javaFieldName}\" type=\"text\" class=\"easyui-validatebox\" required=\"true\"></td>\r\n        </tr>\r\n    #end\r\n#end\r\n\r\n			</table>\r\n		</form>\r\n	</div>\r\n	<div id=\"dlg-buttons\">\r\n		<a href=\"#\" class=\"easyui-linkbutton\" iconCls=\"icon-ok\" onclick=\"crud.save(); return false;\">保存</a>\r\n		<a href=\"#\" class=\"easyui-linkbutton\" iconCls=\"icon-cancel\" onclick=\"crud.closeDlg(); return false;\">取消</a>\r\n	</div>\r\n	\r\n<jsp:include page=\"../easyui_lib.jsp\"></jsp:include>\r\n<script type=\"text/javascript\">\r\nvar that = this;\r\nvar crud = Crud.create({\r\n	pk:\'${context.javaPkName}\'\r\n	,listUrl:ctx + \'list${context.javaBeanName}.do\'\r\n	,addUrl:ctx + \'add${context.javaBeanName}.do\'\r\n	,updateUrl:ctx + \'update${context.javaBeanName}.do\'\r\n	,delUrl:ctx + \'del${context.javaBeanName}.do\'\r\n	,dlgId:\'dlg\'\r\n	,formId:\'fm\'\r\n	,gridId:\'dg\'\r\n});\r\n\r\ncrud.buildGrid([\r\n#set($i=0)\r\n#foreach($column in $columns)\r\n    #if($i>0),#end\r\n    #if(!${column.isIdentityPk})\r\n    {field:\'${column.javaFieldName}\',title:\'${column.javaFieldName}\'}\r\n    #set($i=$i+1)\r\n    #end    \r\n#end \r\n    ,crud.createOperColumn()   \r\n]);\r\n</script>\r\n</body>\r\n</html>','admin'),(14,'durc_Controller',NULL,'package ${context.packageName}.controller;\r\n\r\nimport org.durcframework.core.GridResult;\r\nimport org.durcframework.core.MessageResult;\r\nimport org.durcframework.core.controller.CrudController;\r\nimport ${context.packageName}.entity.${context.javaBeanName};\r\nimport ${context.packageName}.entity.${context.javaBeanName}Sch;\r\nimport ${context.packageName}.service.${context.javaBeanName}Service;\r\nimport org.springframework.stereotype.Controller;\r\nimport org.springframework.web.bind.annotation.RequestMapping;\r\nimport org.springframework.web.bind.annotation.ResponseBody;\r\n\r\n@Controller\r\npublic class ${context.javaBeanName}Controller extends\r\n		CrudController<${context.javaBeanName}, ${context.javaBeanName}Service> {\r\n\r\n	@RequestMapping(\"/add${context.javaBeanName}.do\")\r\n	public @ResponseBody\r\n	MessageResult add${context.javaBeanName}(${context.javaBeanName} entity) {\r\n		return this.save(entity);\r\n	}\r\n\r\n	@RequestMapping(\"/list${context.javaBeanName}.do\")\r\n	public @ResponseBody\r\n	GridResult list${context.javaBeanName}(${context.javaBeanName}Sch searchEntity) {\r\n		return this.query(searchEntity);\r\n	}\r\n\r\n	@RequestMapping(\"/update${context.javaBeanName}.do\")\r\n	public @ResponseBody\r\n	MessageResult update${context.javaBeanName}(${context.javaBeanName} entity) {\r\n		return this.update(enity);\r\n	}\r\n\r\n	@RequestMapping(\"/del${context.javaBeanName}.do\")\r\n	public @ResponseBody\r\n	MessageResult del${context.javaBeanName}(${context.javaBeanName} entity) {\r\n		return this.delete(enity);\r\n	}\r\n	\r\n}','admin');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
