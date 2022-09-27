import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Bootcamp } from 'src/app/models/bootcamp';
import { BootcampAdvice } from 'src/app/models/bootcamp-advice';
import { BootcampReview } from 'src/app/models/bootcamp-review';
import { Tools } from 'src/app/models/tools';
import { User } from 'src/app/models/user';
import { AccountService } from 'src/app/services/account.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-visitor',
  templateUrl: './visitor.component.html',
  styleUrls: ['./visitor.component.css']
})
export class VisitorComponent implements OnInit {
  user: User = new User();
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
  users: User[] = [];
  constructor(
    private userService: UserService,
    private accountservice: AccountService,
    private currentRoute: ActivatedRoute
  ) {}



  ngOnInit(): void {
    this.accountservice.byUsername(this.currentRoute.snapshot.paramMap.get("username")).subscribe({
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
