
Odoo Module Structure

[myimage-alt-tag](http://www.getodootraining.com/wp-content/uploads/2018/10/init__.py_-724x1024.png)

1.__init__.py
It’s initialisation python file of odoo module where all other python file are imported. Means, you can import all the python files directory which used in odoo module. Let’s say in module you have 2 model files named with test.py and hello.py
odoo __init__.py file 
odoo __init__.py file
For example  from . import module or from . import wizard
 

2.__manifest__.py
A manifest file of the module. It contains all information about module like module name,  version, category, description, summary, associated views, demo , data files. it also contain the who written the module author name and it’s website details inside.
 

3.Models
Directory contains all your python (.py) files. All the python models that you create or inherit goes into this directory.
For e.g. –test.py,  hello.py
Note:- All the .py files which is in models folder we must import into __init__.py file
So in main init file you have to import models like this: form . import models
In models there are 3 files test.py, hello.py and init.py. Now in init file of model you have to import those 2 py files like this: from . import hello.py
 

4.Views 
Directory contains all your .xml files. where you can design odoo views like form view, tree view, search views, action, menu etc
 

5.DATA
Data files is necessary files which will load predefined data into database when installing any module/apps in odoo. for example Product module unit of measures is predefined data
 

6.Demo
Demo data files only loaded when you mark “Load demonstration data” true when create database in odoo. otherwise it will not load into database. demo data is testing purpose data which may help how to record data in few application and how to test it with some bunch of pre-loaded data.
Load demonstration data (Check this box to evaluate Odoo)
 

7.Static
Directory having with few sub directory which contain all the website related files like js, img css,xml, font
 SRC
css : It contain all .css files which is use for designing
img:– it contain all images
 js:– it contain all .js files
xml:– it contain all .xmls files used for view/qweb templates
DESCRIPTION
  it contain module brief introduction file called “Index.html” , where you can demonstrate about     module functionality with screen shots
it’s also contain the icon.png file which you used for module icon
 

8.Wizard
It’s contain model that extends the class TransientModel instead of Model and contains it’s view files.
it’s temporary model which will deleted automatically after execute.
 

9.Report 
It contain all the report file. Report all .py (parser) file and .xml file for qweb to design pdf report in odoo
 

10.Security
Directory contain main file to set up access rights, roles and permission, groups etc.
Access rights csv file(ir.model.access.csv)
To assign access like read, write,create, delete permission based on model, user group
security.xml
Which contain to create groups, category, record rules etc.
 

11.controller
Controller file which handle requests from web browsers and response to the server.
 

12.i18n
Directory contains the translation of module in different languages. Mainly contains two type of files .po and .pot. in which .po files are the actual translation files and .pot is the template for the translation.
 

13.Doc
Directory contains documentation file in .doc format which having more information about module functionality.
 

14.Test
In odoo testing file will kept into test directory. it contain different .py and .yml file having different test cases.
