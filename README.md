Odoo Architecture

![myimage-alt-tag](https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ35qQIZ6qYgdZBLDR9Uk6sX0Tw-n4M9a9PhKzedttsWYrO_OoE)
The Data tier is the lowest-level layer, and is responsible for data storage and persistence. Odoo relies on a PostgreSQL server for this. PostgreSQL is the only supported RDBMS, and this is a design choice. So, other databases such as MySQL are not supported. Binary files, such as attachments of documents or images, are usually stored in a filesystem.

The Logic tier is responsible for all the interactions with the data layer, and is handled by the Odoo server. As a general rule, the low-level database should only be accessed by this layer, since it is the only way to ensure security access control and data consistency. At the core of the Odoo server, we have the Object-Relational Mapping (ORM) engine for this interface. The ORM provides the application programming interface (API) used by the addon modules to interact with the data.

For example, the Partner data entity, such as a Customer or a Supplier, is represented in the ORM by a model. This model is a Python object class supporting several interaction methods, such as create() to create new Partner records, or read() to query existing records and their data. These generic methods can implement specific business logic in particular Models. For example,  the create() method might implement default values or enforce validation rules; the read() method might support some automatically computed fields, or enforce access controls depending on the user performing that action.

The Presentation tier is responsible for presenting data and interacting with the user. It is implemented by a client responsible for all the user experience. The client interacts with the ORM API to read, write, verify, or perform any other action, calling ORM API methods through remote procedure calls (RPCs). These are sent to the Odoo server for processing, and then the results are sent back to the client for further handling.

For the Presentation tier, Odoo provides a full-featured web client out of the box. The web client supports all the features needed by a business application: login sessions, navigation menus,  data lists, forms, and so on. The global look and feel are not as customizable as a frontend developer might expect, but it makes it easy to create a functional and consistent user experience.

A complementary presentation layer is the included website framework. It gives full flexibility to create web pages as the exact user interface intended, like in other CMS frameworks, at the expense of some additional effort and web expertise. The website framework supports web controllers to implement code for presenting specific logic, keeping it separate from the model intrinsic logic. Frontend developers will probably feel very much at home in this space.

Due to the openness of the Odoo server API, other client implementations are possible, and could be built in almost any platform or programming language. Desktop and smartphone apps can be built to provide specific user interfaces, leveraging the Odoo Data and Logic tiers for business logic and data persistence.

A particular example of a third-party Odoo client is ERPpeek. It is a command- line client, allowing you to connect and interact with remote Odoo servers. It can be useful for developers or system administrators with Odoo technical knowledge, to inspect data on the server, script advanced operations, or perform maintenance operations. We will present an overview of ERPpeek in Chapter 8, External API – Integrating with Other Systems.

