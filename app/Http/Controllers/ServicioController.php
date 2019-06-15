<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Cliente;
use App\Ubicacion;
use App\Personal;
use App\Nota_servicio;
use App\Marcado;


use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;

class ServicioController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $nota=DB::table('nota_servicio as n')
        ->join('cliente as c','n.id_cliente','=','c.id')
        ->join('personal as p','n.id_personal','=','p.id')
        ->select('c.nombre as cliente','n.descripcion','n.fecha_hora','p.nombre as personal','n.estado')
        ->orderBy('n.id')->get();
        
        //dd($servicio);
        //return $servicio->toJson();
        return view('crud.servicio.index',compact('nota'));


    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        $personal=DB::table('personal')->get();
        $cliente=DB::table('cliente')->get();
        $ubicacion=DB::table('ubicacion')->get();
        return view('crud.servicio.create',['personal'=>$personal,'cliente'=>$cliente,'ubicacion'=>$ubicacion]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        $servicio=new Nota_servicio($request->all());
        $servicio->id_cliente=$request->get('id_cliente');
        $servicio->descripcion=$request->get('descripcion');
        
        $servicio->fecha_hora=$request->get('fecha_hora');
        $servicio->id_personal=$request->get('id_personal');
        $servicio->estado='0';
        $servicio->save();
        //dd($personal);
        return redirect('servicio');

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */





    public function show($id)
    {
        //
        $servicio=DB::table('cliente as c')


        ->join('nota_servicio as n','n.id_cliente','=','c.id')
        ->join('personal as p','p.id','=','n.id_personal')
        ->join('ubicacion as u','c.id_ubicacion','=','u.id')
        
        ->select('n.id as id','n.descripcion as description','c.nombre as customer_name','n.estado as state','c.telefono','u.x as lng','u.y as lat')

        ->where('p.id','=',$id)
        ->get();

        $datos= file_get_contents("archivo (1).json");
       

      
     
        return ($servicio);
        
        /*return response()->json($datos);*/
    }

   /* public function person(){

        $personal=DB::table('personal as p')
        ->where('p.estado','=','1')
        ->join('marcado as m','m.id_personal','=','p.id')
        ->join('ubicacion as u','u.id','=','m.id_ubicacion')
        ->select('p.nombre as personal','u.nombre as ubicacion','u.x as longitud','u.y as latitud')
        ->get();
        
        //dd($servicio);
        return $personal->toJson();

    }*/

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
