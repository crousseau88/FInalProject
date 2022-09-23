export class User {

  id: number =0 ;
  username: string = '';
  password: string= '';
  active: boolean = false;
  role: string= '';
  firstName: string= '';
  lastName: string= '';
  email: string= '';
  aboutMe: string= '';
  profileImg:  string= '';

  constructor(
    id: number =0 ,
    username: string = '',
    password: string= '',
    active: boolean = false,
    role: string= '',
    firstName: string= '',
    lastName: string= '',
    email: string= '',
    aboutMe: string= '',
    profileImg:  string= ''
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.active = active;
    this.role = role;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.aboutMe = aboutMe;
    this.profileImg = profileImg;
  }

}
