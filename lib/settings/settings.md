# Settings folder

> FEATURE DESCRIPTION HERE

***

**A. Models used :**

* [WsXResponse](./data/models/ws_x_response.dart)
* [X](./domain/models/x.dart)
* [UiX](./presentation/models/ui_x.dart)

**B. Folder Structure :**

* settings/
  * [data/](./data/)
    * [models/](./data/models/)
    * [repositories/](./data/repositories/)
    * [services/](./data/services/)
  * [domain/](./domain/)
    * [models/](./domain/models/)
    * [repositories/](./domain/repositories/)
    * [use_cases/](./domain/use_cases/)
  * [presentation/](./presentation/)
    * [models/](./presentation/models/)
    * [views/](./presentation/views/)
      * [states/](./presentation/views/states/)
      * [widgets/](./presentation/views/widgets/)

 1. [data](./data/) :

     The "data" folder is responsible for handling data-related operations, including data access, storage, and communication with external sources. It acts as the lowest level in the architecture and provides a clear boundary between the application and external data sources.

    * [models](./data/models/) :

      In the "models" subfolder, we store data models that represent the structure of data entities retrieved or sent from the data sources. These models may differ from the domain models, as they are optimized for data manipulation and storage.

    * [repositories](./data/repositories/) :

      This subfolder contains interfaces and implementations of repositories that define data access methods for the domain layer. Repositories are responsible for abstracting data retrieval and persistence logic, enabling the domain layer to remain independent of the data source details.

    * [services](./data/services/) :

      The "services" subfolder holds implementations of data sources, such as APIs, databases, or local storage. These classes communicate with external data sources and transform raw data into domain models.

 2. [domain](./domain/) :

     The "domain" folder represents the core of our application and contains business logic, entities, and use cases. This layer is independent of external dependencies, making it highly portable and reusable.

    * [models](./domain/models/) :

      The "models" subfolder houses the domain entities, which encapsulate the core business logic and state of the application. Entities are at the heart of the application and are devoid of any framework-specific code.

    * [repositories](./domain/repositories/) :

      The "repositories" subfolder contains interfaces that define the contract for data access in the domain layer. These interfaces are implemented in the "data" layer, allowing the domain layer to interact with data without direct dependencies on data sources.

    * [use_cases](./domain/use_cases/) :

      Use cases, residing in the "use_cases" subfolder, represent high-level operations and business processes. They define the interactions between the domain entities and facilitate the application's behavior.

 3. [presentation](./presentation/) :

     The "presentation" folder is responsible for handling user interface (UI) and user interaction. This layer interacts with the domain layer through use cases and serves as a mediator between the user and the application's core logic.

    * [models](./presentation/models/) :

      Models are located in the "models" subfolder and represent the data structure required by the views.
    * [views](./presentation/views/) :

      The "views" subfolder contains classes responsible for displaying information to the user. These classes are platform-specific and interact with presenters or view models to update the UI.

      * [states](./presentation/views/states/) :

        View states are located in the "states" subfolder and represent the data state required by the views.

      * [widgets](./presentation/views/widgets/) :

        The "widgets" subfolder contains subclasses responsible for displaying the UI.
