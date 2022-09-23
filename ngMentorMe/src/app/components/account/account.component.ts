import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';
import { AccountService } from 'src/app/services/account.service';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.css']
})
export class AccountComponent implements OnInit {
  user: User = new User();

  users: User[] = []; //mentors/mentees

  selected: User | null = null;

  newUser: User = new User();

  allUsers: User[]= [];//display all users

  editUser: User | null = null;
  constructor(
    private userService: UserService,
    private accountservice: AccountService,
    private route: ActivatedRoute,
    private authservice: AuthService,
    private router:  Router) {

   }

  ngOnInit(): void {

      this.authservice.getLoggedInUser().subscribe({
        next: (user) => {
          this.user = user;
        },
        error: (err) => {
          console.error('Error retrieving user');
          console.error(err);
        }
      });
  }

  routeHomeAfterDelete() {
    this.authservice.logout();
    this.router.navigateByUrl('/home');
  }
  deleteUser(id: number) {
    this.accountservice.destroy(id).subscribe({
      next: () => {
        this.reload();
      },
      error: (err) => {
        console.error('Error deleting user');
        console.error(err);
      }
    });
  }

  updateUser(user: User) {
    this.accountservice.update(user).subscribe({
      next: (result) => {
        this.selected = result;
        this.editUser = null;
        this.reload;
      },
      error: (err) => {
        console.error('Error updating user');
        console.error(err);
      },
    });
}

reload(): void {
  this.accountservice.index().subscribe({
    next: (users) => {
      this.users = users;
    },
    error: (problem) => {
      console.error('UserListHttpComponent.reload(): error loading users:');
      console.error(problem);
    },
  });
}
}


