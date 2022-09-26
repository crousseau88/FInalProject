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

  createPost(post: any): Observable<PostInterface> {
    return this.http.post<PostInterface>(
      this.url + 'posts',
      post,
      this.getHttpOptions()
    );
  }
}
