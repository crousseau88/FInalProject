export class Tools {
  bootcampAdviceId: number = 0;
  name: string = '';
  toolType: string = '';
  why: string = '';
  website: string = '';
  notes: string = '';

  constructor(
    bootcampAdviceId: number = 0,
    name: string = '',
    toolType: string = '',
    why: string = '',
    website: string = '',
    notes: string = ''
  ) {
    this.bootcampAdviceId = 0;
    this.name = '';
    this.toolType = '';
    this.why = '';
    this.website = '';
    this.notes = '';
  }
}
