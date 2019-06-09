<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');


Route::get('/principal', function () {
    return view('layouts.principal');
});
Route::get('/mapa', function () {
    return view('layouts.mapa');
});

Route::resource('personal','PersonalController');
Auth::routes();

Route::resource('cliente','ClienteController');
Auth::routes();

Route::resource('ubicacion','UbicacionController');
Auth::routes();

Route::resource('contrato','ContratoController');
Auth::routes();
Route::resource('horarios','HorariosController');
Auth::routes();

Route::get('person', 'MapaController@person');
Auth::routes();
//Route::resource('servicio','ServicioController');
//Auth::routes();


Route::resource('servicio','ServicioController');
Auth::routes();

Route::get('cliente/{id}/{id_servicio}', 'ClienteController@show');

// Route::post('/empleado', 'UsuarioController@signup');
// Auth::routes();`
Route::resource('horas','Horas_extrasController');
Auth::routes();

Route::resource('horas_t','Hora_tController');
Auth::routes();