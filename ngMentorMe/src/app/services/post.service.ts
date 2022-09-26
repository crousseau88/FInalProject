import { Reply } from './../models/reply';
import { User } from 'src/app/models/user';
import { Post } from 'src/app/models/post';
import { AppModule } from './../app.module';
import { PostModule } from './../post.module';
import { PostInterface } from './../interfaces/post';
import { catchError, Observable, throwError } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class PostService {
  private url = environment.baseUrl + 'api/';
  constructor(private http: HttpClient, private auth: AuthService) {}

  index() {
    return this.http.get<PostInterface[]>(this.url + 'posts/').pipe(
      //controller needed for all users
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('userService.index():error retreiving ALL posts' + err)
        );
      })
    );
  }

  getPosts(username: string) {
    return this.http.get<PostInterface[]>(this.url + 'posts/' + username).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('userService.show():error retrieving Posts' + err)
        );
      })
    );
  }

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  show(postId: any) {
    return this.http
      .get<PostInterface>(this.url + '/' + postId, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error('PostService.show():error retrieving Post list: ' + err)
          );
        })
      );
  }
  getAllPosts(): Observable<PostInterface[]> {
    return this.http.get<PostInterface[]>(this.url + '/posts');
  }






  getAllRealPosts(): Observable<Post[]> {
    return this.http.get<Post[]>(this.url + 'posts').pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('PostService.getRealPosts():error retrieving Post list: ' + err)
        );
      })
    );
  }
  getPostsReplies(postId: number) {
    return this.http.get<Reply[]>(
      this.url + 'replies/' + postId).pipe(catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('PostService.getPostReplies():error retrieving reply list: ' + err)
        );
      })
    );
  }
  create(post: Post):Observable <Post> {
    return this.http.post<Post>(this.url + 'posts', post, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('PostService.getPostReplies():error retrieving reply list: ' + err)
        );
      })
    );
  }

  createPost(post: any): Observable<PostInterface> {
    return this.http.post<PostInterface>(
      this.url + 'posts',
      post,
      this.getHttpOptions()
    );
  }

  delete(postId: number) {
    return this.http.delete<Post>(
      this.url + 'posts/' + postId,
      this.getHttpOptions()
    ).pipe( catchError((err: any) => {
      console.log(err);
      return throwError(
        () =>
          new Error('PostService.DELETE():error DELETING POST: ' + err)
      );
    })
  );
  }

  createCommentOnPost(postId: number, comment: Reply) {
    delete comment.postId;
    delete comment.user;
    delete comment.created;
    delete comment.updated;
    delete comment.replyId;
    return this.http.post<Reply>(
      this.url + 'replies/' + postId,
      comment,
      this.getHttpOptions()
    ).pipe( catchError((err: any) => {
      console.log(err);
      return throwError(
        () =>
          new Error('PostService.CREATECOMMENTONPOST():error CREATING COMMENT: ' + err)
      );
    })
  );
  }

  deleteCommentOnPost(postId: number, commentId: number) {
    return this.http.delete<Reply>(
      this.url + 'replies/' + postId + '/' + commentId,
      this.getHttpOptions()
    ).pipe( catchError((err: any) => {
      console.log(err);
      return throwError(
        () =>
          new Error('PostService.DELETECOMMENTONPOST():error DELETING COMMENT: ' + err)
      );
    })
  );
  }
}
