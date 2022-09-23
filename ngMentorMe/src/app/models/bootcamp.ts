export class Bootcamp {
  id: number = 0;
  name: string = '';
  website: string = '';
  imagUrl: string = '';
  length: number = 0;
  description: string = '';

  constructor(
  id: number = 0,
  name: string = '',
  website: string = '',
  imagUrl: string = '',
  length: number = 0,
  description: string = ''
  ) {
    this.id = id;
    this.name = name;
    this.website = website;
    this.imagUrl = imagUrl;
    this.length = length;
    this.description = description;
  }

}
