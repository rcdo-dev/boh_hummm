import 'package:boh_hummm/data/model/user_model.dart';

final userPLaMNuM = UserModel(
  use_id: 1, // O id não tem que ir. auto increment.
  use_name: 'PLaMNuM',
  use_email: 'PLaMNuM@test.com',
  use_image_path: 'path/plamnum.jpg',
);

final userPLaMNuMUpdate = UserModel(
  use_id: 3,
  use_name: 'PLaMNuM',
  use_email: 'PLaMNuM_email_update@test.com',
  use_image_path: 'path/plamnum.jpg',
);

final userSTanCel = UserModel(
  use_id: 2,
  use_name: 'STanCel',
  use_email: 'STanCel@test.com',
  use_image_path: 'path/stancel.jpg',
);
