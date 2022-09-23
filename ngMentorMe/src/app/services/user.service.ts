import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError } from 'rxjs';
import { throwError } from 'rxjs/internal/observable/throwError';
import { environment } from 'src/environments/environment';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private url = environment.baseUrl + 'api/';
  constructor(private http: HttpClient) { }

  index() {
    return this.http.get<User[]>(this.url + '/users').pipe( //controller needed for all users
      catchError((err: any) => {
        console.log(err);
        return throwError( ()=> new Error (
          'userService.index():error retreiving Users' + err
        ));
      }
    ));
  }

  byUsername(username: string) {
    console.log(username);
    return this.http.get<User>(this.url + '/account/' + username).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError( ()=> new Error (
          'userService.byUsername():error retrieving User' + err
        ));
      }
    ));
  }



  create(user: User) {
    return this.http.post<User>(this.url + '/register', user).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError( ()=> new Error (
          'userService.create():error creating User' + err
        ));
      }
    ));
  }

  update(user: User) {
    return this.http.put<User>(this.url + 'auth/' + user.id, user).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError( ()=> new Error (
          'userService.update():error updating User' + err
        ));
      }
    ));
  }
  destroy(id: number) {
    return this.http.delete<void>(this.url + 'auth/' + id).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError( ()=> new Error (
          'userService.destroy():error deleting User' + err
        ));
      }
    ));
  }

  show(username: string) {
    return this.http.get<User>(this.url + 'account/' + username).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError( ()=> new Error (
          'userService.show():error retrieving User' + err
        ));
      }
    ));
  }
}
