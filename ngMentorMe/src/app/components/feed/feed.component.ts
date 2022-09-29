import { UserService } from './../../services/user.service';
import { ActivatedRoute, Router } from '@angular/router';
import { PostService } from './../../services/post.service';
import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { Reply } from 'src/app/models/reply';
import { formatCurrency } from '@angular/common';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { AccountService } from 'src/app/services/account.service';
import { Bootcamp } from 'src/app/models/bootcamp';
import { BootcampAdvice } from 'src/app/models/bootcamp-advice';
import { BootcampReview } from 'src/app/models/bootcamp-review';
import { Tools } from 'src/app/models/tools';
import { AngularPaginatorModule } from 'angular-paginator';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css'],
})
export class FeedComponent implements OnInit {
  page = 1;
  pageSize = 5;
  posts: Post[] = [];
  newPostReplies: Reply[] = [];
  newPost: Post = new Post();
  user: User = new User();
  visitor: string = '';
  newComment: Reply = new Reply();
  selectedUser: User | null = null;
  bootcamps: Bootcamp[] = [];
  bootReviews: BootcampReview[] = [];
  advice: BootcampAdvice | null = null;
  tools: Tools[] = [];
  userIsMentor: boolean = false;
  showReviews: boolean = false;
  allFollowers: User[] = [];
  allFollowing: User[] = [];
  isFollowing: boolean = false;

  constructor(
    private auth: AuthService,
    private postServ: PostService,
    private router: Router,
    private accountservice: AccountService,
    private currentRoute: ActivatedRoute,
    private userService: UserService
    ) {}

  ngOnInit(): void {

    this.router.routeReuseStrategy.shouldReuseRoute = () => false;
    this.auth.getLoggedInUser().subscribe({
      next: (user) => {
        this.visitor = user.username;
        this.loadPosts();
        this.user = user;
      },
      error: (err) => {
        console.error('Error retrieving user');
        console.error(err);
      },
    });
  }
  loadPosts() {
    this.postServ.getAllRealPosts().subscribe({

      next: (posts) => {
        this.posts = posts.sort(
          (a, b) =>
            new Date(b.created).getTime() - new Date(a.created).getTime()
        );

        this.newPostReplies = [];
        for (let i = 0; i < this.posts.length; i++) {
          this.newPostReplies.push(new Reply());
        }
      },
      error: (err) => {
        console.error('Error retrieving posts: ' + err);
      },
    });
  }
  createNewPost(post: Post) {
    if(post.text === "" || post.subject === ""){
       return alert("Please fill out all fields");
    }

    this.postServ.create(post).subscribe({
      next: (post) => {
        this.posts.push(post);
        this.loadPosts();
      },
      error: (err) => {
        console.error('Error creating post: ' + err);
      },
    });
  }

  deletePost(postId: number) {
    if(confirm("Are you sure you want to delete this post?")){
      this.postServ.delete(postId).subscribe({
        next: (post) => {
          this.loadPosts();
        },
        error: (err) => {
          console.error('Error creating post: ' + err);
        },
      });
    }
  }

  reload() {
    window.location.reload();
  }

  createNewComment(comment: Reply, postId: number) {
    if(comment.text === ""){
      return alert("Please fill out all fields");
    }
    this.postServ.createCommentOnPost(postId, comment).subscribe({
      next: (comment) => {
        // this.reload();
        this.loadPosts();
      },
      error: (err) => {
        console.error('Error creating post: ' + err);
      },
    });
  }

  deleteComment(postId: number, commentId: number) {
    if(confirm("Are you sure you want to delete this comment?")){
      this.postServ.deleteCommentOnPost(postId, commentId).subscribe({
        next: (comment) => {
          this.loadPosts();
        },
        error: (err) => {
          console.error('Error deleteing comment on post: ' + err);
        },
      });
    }
  }

  visitUserPage(otherUser: string) {
    this.router.navigateByUrl(`/visitor/${otherUser}`);
  }
// ---------------------------------Start of User----------------------------------------------------------
  setSelectedUser(username: any) {
    this.selectedUser = null;
    this.userService.show(username).subscribe({
      next: (user) => {
        this.selectedUser = user;
         this.allfollowers(this.selectedUser);
        this.allfollowing(this.selectedUser.username);
        this.bootcampsAttended(this.selectedUser.username);
        this.bootcampReviews(this.selectedUser.username);
      },
      error: (err) => {
        console.error('Error retrieving user');
        console.error(err);
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
        followers.forEach(person => {
          if(person.username === this.user.username){
            this.isFollowing = true;
          }
        });
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
      },
      error: (problem) => {
        console.error(
          'UserListHttpComponent.reload(): error loading FOLLOWING'
        );
        console.error(problem);
      },
    });
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

  followMe(user: User) {
    this.accountservice.followUser(user.id, this.user).subscribe({
      next: (users) => {
        this.setSelectedUser(this.selectedUser?.username);
        this.allFollowing = users;

      },
      error: (err) => {
        console.error('Error following this user');
        console.error(err);
      },
    });
  }
  unFollowMe(user: User) {
    this.accountservice.unFollowUser(user.id, this.user).subscribe({
      next: (users) => {
        this.isFollowing = false;
        this.setSelectedUser(this.selectedUser?.username);
        this.allFollowers = users;
        this.allfollowers(user);
      },
      error: (err) => {
        console.error('Error following this user');
        console.error(err);
      },
    });

  }
}
