import { BootcampAdvice } from 'src/app/models/bootcamp-advice';
import { BootcampService } from 'src/app/services/bootcamp.service';
import { Tools } from './../../models/tools';
//import { BootcampAdvice } from './../../models/bootcamp-advice';
import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';
import { AccountService } from 'src/app/services/account.service';
import { Bootcamp } from 'src/app/models/bootcamp';
import { BootcampReview } from 'src/app/models/bootcamp-review';
import { Post } from 'src/app/models/post';

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
  bootcampId: number = 0;
  bootReviews: BootcampReview[] = [];
  newReview: BootcampReview = new BootcampReview();
  advice: BootcampAdvice | null = null;
  tools: Tools[] = [];
  posts: Post[] = [];
  userIsMentor: boolean = false;
  showReviews: boolean = false;
  isFollowing: boolean = false;
  createReview: boolean = false;
  bootAdvice: BootcampAdvice = new BootcampAdvice();
  showButton: boolean = true;
  addAdvice: boolean = false;
  addNewAdvice: boolean = false;
  newAdvice: BootcampAdvice = new BootcampAdvice();

  constructor(
    private userService: UserService,
    private accountservice: AccountService,
    private route: ActivatedRoute,
    private authservice: AuthService,
    private router: Router,
    private bootcampService: BootcampService
  ) {}

  ngOnInit(): void {
    this.authservice.getLoggedInUser().subscribe({
      next: (user) => {
        this.user = user;
        this.allfollowers(this.user);
        this.allfollowing(this.user.username);
        this.bootcampsAttended(this.user.username);
        this.bootcampReviews(this.user.username);
        this.userPosts(this.user.username);
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
        if (followers.includes(this.user)) {
          this.isFollowing = true;
        }
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
    if (!this.showReviews) {
      this.showReviews = true;
      this.bootcampReviews(this.user.username);
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
        if (bootcamps.length === 0) {
          this.showButton = false;
        }
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

  userPosts(username: string) {
    this.accountservice.getPosts(username).subscribe({
      next: (posts) => {
        this.posts = posts;
      },
      error: (problem) => {
        console.error(
          'UserListHttpComponent.reload(): error loading FOLLOWING'
        );
        console.error(problem);
      },
    });
  }
  toggleReview() {
    if (!this.createReview) {
      this.createReview = true;
    } else {
      this.createReview = false;
    }
  }
  showAdvice() {
    if (!this.addAdvice) {
      this.addAdvice = true;
    }
  }
  hideAdvice() {
    if (this.addAdvice) {
      this.addAdvice = false;
    }
  }

  submitAdvice(advice: BootcampAdvice, reviewId: number) {
    this.bootcampService.createAdvice(reviewId, advice).subscribe({
      next: (advice) => {
        this.advice = advice;
        this.addAdvice = false;
        this.ngOnInit();
        window.location.reload();
      },
      error: (err) => {
        console.error('Error creating review');
        console.error(err);
      },
    });
  }
  addReview(bootcampReview: BootcampReview, bootId: number) {
    this.bootcampService.createReview(bootcampReview, bootId).subscribe({
      next: (review) => {
        this.bootReviews.push(review);
        this.createReview = false;
        this.ngOnInit();
        window.location.reload();
      },
      error: (err) => {
        console.error('Error creating review');
        console.error(err);
      },
    });
  }
  calculateRating(review: BootcampReview) {
    let average =
      (review.instructorRating +
        review.jobAssistanceRating +
        review.curriculumRating) /
      3;
    console.log(review);
    return Math.floor(average);
  }
}
