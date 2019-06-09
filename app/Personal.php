<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Personal extends Model
{
    //
    protected $table = 'personal';
    public $timestamps = false;
    protected $primayKey='id';
    protected $fillable = [
        'id',
        'nombre',
        'cedula',
        'huella', 
        'foto',
        'id_cargo', 
        'estado',
    ]; 
}
