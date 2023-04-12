import 'package:flutter/material.dart';
import 'package:gypse/auth/domain/models/user.dart';

///<i><small>`Domain Layer`</small></i>
///## User repository
///
///It defines all the methods that must be implemented to manage users in the database.<br>
///<li>initialization - [initUser]
///<li>add - [onNewUser]
///<li>get - [getCurrentUser]
///<li>update - [onUserChanged]
///<li>delete - [onDeleteUser]
abstract class UserRepository {
  ///<i><small>`Domain Layer`</small></i>
  ///## User creation
  ///
  ///Function to create a new user in the database <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<void> onNewUser(User user);

  ///<i><small>`Domain Layer`</small></i>
  ///## Fetch user
  ///
  ///Function to fetch a user from the database <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<User> getCurrentUser(String id);

  ///<i><small>`Domain Layer`</small></i>
  ///## Update user
  ///
  ///Function to modify user from the database <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<void> onUserChanged(BuildContext context, User user);

  ///<i><small>`Domain Layer`</small></i>
  ///## Delete user
  ///
  ///Function to remove user from the database <br><hr><br>
  ///<i>Errors are handled, logged and thrown with a [GypseException].</i>
  Future<void> onDeleteUser(BuildContext context, String id);
}
