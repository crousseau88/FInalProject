import { AuthService } from './auth.service';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';
import { Bootcamp } from '../models/bootcamp';
import { BootcampReview } from '../models/bootcamp-review';
import { BootcampAdvice } from '../models/bootcamp-advice';
import { Tools } from '../models/tools';

@Injectable({
  providedIn: 'root',
})
export class AccountService {
  private url = environment.baseUrl + 'api/';
  constructor(private http: HttpClient, private auth: AuthService) {}

  index() {
    return this.http.get<User[]>(this.url + '/users').pipe(
      //controller needed for all users
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('userService.index():error retreiving Users' + err)
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
  byUsername(username: string) {
    console.log(username);
    return this.http.get<User>(this.url + '/account/' + username).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('userService.byUsername():error retrieving User' + err)
        );
      })
    );
  }

  create(user: User) {
    return this.http.post<User>(this.url + '/register', user).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('userService.create():error creating User' + err)
        );
      })
    );
  }

  update(user: User) {
    return this.http
      .put<User>(this.url + 'account', user, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('userService.update():error updating User' + err)
          );
        })
      );
  }
  destroy(id: number) {
    return this.http
      .delete<void>(this.url + 'account', this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('userService.destroy():error deleting User' + err)
          );
        })
      );
  }

  show(username: string) {
    return this.http.get<User>(this.url + 'account' + username).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('userService.show():error retrieving User' + err)
        );
      })
    );
  }

  getfollowers(username: string) {
    console.log('USERNAME PASSED FOR FOLLOWERS: ' + username);
    return this.http.get<User[]>(this.url + username + '/followers').pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('userService.show():error retrieving followers' + err)
        );
      })
    );
  }
  getfollowing(username: string) {
    return this.http.get<User[]>(this.url + username + '/following').pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('userService.show():error retrieving followING' + err)
        );
      })
    );
  }

  getBootcamps(username: string) {
    return this.http.get<Bootcamp[]>(this.url + 'bootcamps/' + username).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('userService.show():error retrieving Bootcamps' + err)
        );
      })
    );
  }
  // getClickedBootcamp(username: string, bootcampReviewId: number) {
  //   return this.http.get<Bootcamp>(this.url + 'bootcamps/' + username).pipe(
  //     catchError((err: any) => {
  //       console.log(err);
  //       return throwError(
  //         () => new Error('userService.show():error retrieving Bootcamps' + err)
  //       );
  //     })
  //   );
  // }

  getBootcampReviews(username: string) {
    return this.http
      .get<BootcampReview[]>(this.url + 'bootcamps/' + 'reviews/' + username)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'userService.show():error retrieving BootcampReviews' + err
              )
          );
        })
      );
  }

  getBootcampAdvice(reviewId: number) {
    return this.http.get<BootcampAdvice>(this.url + 'advice/' + reviewId).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'userService.show():error retrieving BootcampAdvice' + err
            )
        );
      })
    );
  }

  getTools(adviceId: number) {
    return this.http.get<Tools[]>(this.url + 'tools/' + adviceId).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error(
              'userService.show():error retrieving BootcampAdvice' + err
            )
        );
      })
    );
  }
}
