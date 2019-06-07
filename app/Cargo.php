<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Cargo extends Model
{
    //
    protected $table = 'cargo';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'nombre',
        'descripcion',
    ]; 



}
