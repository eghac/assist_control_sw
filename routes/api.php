<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/empleado', 'UsuarioController@signup');
// return response('Hello World', 200)

Route::get('/contrato/{id}', 'ContratoController@show');

Route::get('/login/{email}/{password}', 'UsuarioController@show');


Route::post('/marcado', 'MarcadoController@store');
//Route::get('/marcados', 'MarcadoController@show');
Route::get('/servicio/{id}', 'ServicioController@show');

Route::get('/ruta/{id}', 'MapaController@ruta');



