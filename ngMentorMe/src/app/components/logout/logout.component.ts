import { catchError } from 'rxjs';
import { Component, OnInit, Pipe } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent implements OnInit {

  constructor(
    private auth: AuthService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  logout(){
    console.log("Loging out");
    try{
      this.auth.logout();
      this.router.navigateByUrl('home');
    }
    catch(err){
      console.error('logout.component.logout() error: ' + err);
    }

  }
}
