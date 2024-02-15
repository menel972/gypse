# Tutorial folder

> Tutorial screen. Part of the application's onboarding process, it provides instructions and guidance for users to learn how to use all functionalities.

***

**A. Folder Structure :**

* tutorial/
  * [presentation/](./presentation/)
    * [views/](./presentation/views/)
      * [states/](./presentation/views/states/)

 1. [presentation](./presentation/) :

     The "presentation" folder is responsible for handling user interface (UI) and user interaction. This layer interacts with the domain layer through use cases and serves as a mediator between the user and the application's core logic.

    * [views](./presentation/views/) :

      The "views" subfolder contains classes responsible for displaying information to the user. These classes are platform-specific and interact with presenters or view models to update the UI.

      * [states](./presentation/views/states/) :

        View states are located in the "states" subfolder and represent the data state required by the views.
