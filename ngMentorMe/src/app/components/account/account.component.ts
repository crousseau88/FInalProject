import { AuthService } from 'src/app/services/auth.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.css']
})
export class AccountComponent implements OnInit {
  user: User = new User();

  constructor(
    private userService: UserService,
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

  }


