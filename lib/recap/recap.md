# Recap folder

> Summary screen of the last game session.

***

**A. Models used :**

* [RecapSessionState](../game/presentation/views/states/game_states.dart)

**B. Folder Structure :**

* recap/
  * [presentation/](./presentation/)
    * [views/](./presentation/views/)
      * [widgets/](./presentation/views/widgets/)

 1. [presentation](./presentation/) :

     The "presentation" folder is responsible for handling user interface (UI) and user interaction. This layer interacts with the domain layer through use cases and serves as a mediator between the user and the application's core logic.

    * [views](./presentation/views/) :

      The "views" subfolder contains classes responsible for displaying information to the user. These classes are platform-specific and interact with presenters or view models to update the UI.

      * [widgets](./presentation/views/widgets/) :

        The "widgets" subfolder contains subclasses responsible for displaying the UI.
