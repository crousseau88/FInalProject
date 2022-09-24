import { Tools } from './../../models/tools';
import { BootcampAdvice } from './../../models/bootcamp-advice';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';
import { AccountService } from 'src/app/services/account.service';
import { Bootcamp } from 'src/app/models/bootcamp';
import { BootcampReview } from 'src/app/models/bootcamp-review';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.css'],
})
export class AccountComponent implements OnInit {
  user: User = new User();

  users: User[] = []; //mentors/mentees

  selected: User | null = null;
  selectedBootcamp: Bootcamp | null = null;

  newUser: User = new User();

  allUsers: User[] = []; //display all users
  allFollowers: User[] = [];
  allFollowing: User[] = [];
  editUser: User | null = null;
  bootcamps: Bootcamp[] = [];
  bootReviews: BootcampReview[] = [];
  advice: BootcampAdvice | null = null;
  tools: Tools[] = [];

  userIsMentor: boolean = false;
  showReviews: boolean = false;

  constructor(
    private userService: UserService,
    private accountservice: AccountService,
    private route: ActivatedRoute,
    private authservice: AuthService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.authservice.getLoggedInUser().subscribe({
      next: (user) => {
        this.user = user;
        this.allfollowers(this.user);
        this.allfollowing(this.user.username);
        this.bootcampsAttended(this.user.username);
        this.bootcampReviews(this.user.username);
      },
      error: (err) => {
        console.error('Error retrieving user');
        console.error(err);
      },
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
      },
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

  allfollowers(user: User) {
    this.accountservice.getfollowers(user.username).subscribe({
      next: (followers) => {
        this.allFollowers = followers;
      },
      error: (problem) => {
        console.error(
          'UserListHttpComponent.reload(): error loading FOLLOWERS:'
        );
        console.error(problem);
      },
    });
  }

  allfollowing(username: string) {
    this.accountservice.getfollowing(username).subscribe({
      next: (followers) => {
        this.allFollowing = followers;
      },
      error: (problem) => {
        console.error(
          'UserListHttpComponent.reload(): error loading FOLLOWING'
        );
        console.error(problem);
      },
    });
  }
  // BOOLEAN SWITCH FUNCTIONS

  userRoleIsMentor() {
    console.log(this.user.role === 'MENTOR');
    if (this.user.role === 'MENTOR') {
      this.userIsMentor = true;
    } else {
      this.userIsMentor = false;
    }
  }

  showReview() {
    console.log('Show Review boolean before IF statement: ' + this.showReview);
    if (!this.showReviews) {
      this.showReviews = true;
      this.bootcampReviews(this.user.username);
      console.log('Show Review boolean AFTER IF statement: ' + this.showReview);
    } else {
      this.showReviews = false;
    }
  }

  bootcampsAttended(username: string) {
    this.accountservice.getBootcamps(username).subscribe({
      next: (bootcamps) => {
        this.bootcamps = bootcamps;
      },
      error: (problem) => {
        console.error(
          'UserListHttpComponent.reload(): error loading FOLLOWING'
        );
        console.error(problem);
      },
    });
  }
  bootcampReviews(username: string) {
    this.accountservice.getBootcampReviews(username).subscribe({
      next: (bootcamps) => {
        this.bootReviews = bootcamps;
        console.log(this.bootReviews);
      },
      error: (problem) => {
        console.error(
          'UserListHttpComponent.reload(): error loading FOLLOWING'
        );
        console.error(problem);
      },
    });
  }

  bootcampAdvice(reviewId: number) {
    this.accountservice.getBootcampAdvice(reviewId).subscribe({
      next: (advice) => {
        this.advice = advice;
        console.log(this.advice);
      },
      error: (problem) => {
        console.error(
          'UserListHttpComponent.reload(): error loading FOLLOWING'
        );
        console.error(problem);
      },
    });
  }

  bootcampTools(adviceId: number) {
    this.accountservice.getTools(adviceId).subscribe({
      next: (tools) => {
        this.tools = tools;
        console.log(this.tools);
      },
      error: (problem) => {
        console.error(
          'UserListHttpComponent.reload(): error loading FOLLOWING'
        );
        console.error(problem);
      },
    });
  }
}
