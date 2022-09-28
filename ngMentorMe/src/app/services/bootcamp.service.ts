import { BootcampReview } from 'src/app/models/bootcamp-review';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Bootcamp } from '../models/bootcamp';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class BootcampService {

  private url = environment.baseUrl + 'api/';
  constructor(private http: HttpClient, private auth: AuthService) {}

  index() {
    return this.http.get<Bootcamp[]>(this.url + 'bootcamps').pipe(
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
getReviews(id: number) {
  return this.http.get<BootcampReview[]>(this.url + 'reviews/' + id).pipe(
    catchError((err: any) => {
      console.log(err);
      return throwError(
        () => new Error('userService.index():error retreiving Users' + err)
        );
      })
    );
  }
  getBootcampsByKeyword(keyword: string) {
    return this.http.get<Bootcamp[]>(this.url + 'bootcamps/search/' + keyword).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('userService.index():error retreiving Users' + err)
          );
        })
      );
    }
    createReview(review: BootcampReview, bootId: number) {
      return this.http.post<BootcampReview>(this.url + 'reviews/' + bootId, review, this.getHttpOptions() ).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('userService.index():error retreiving Users' + err)
            );
          })
        );
      }
}
