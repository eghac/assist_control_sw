<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Cliente;
use App\Ubicacion;
use App\Nota_servicio;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;

class ClienteController extends Controller
{
    /**
     * Display a listing of the resource............
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $cliente=DB::table('cliente as c')
        ->join('ubicacion as u','c.id_ubicacion','=','u.id')
        ->select('c.nombre','u.nombre as ubicacion','c.telefono')
        ->orderBy('c.id')->get();
                
        //dd($cliente);
        //return $cliente->toJson();
        return view('crud.cliente.index',compact('cliente'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        //$ubicacion=DB::table('ubicacion')->select(DB::raw('max(id) as id'))->groupBy('id')->get();
        //return view('crud.cliente.create',['ubicacion'=>$ubicacion]);
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
       // $ubicacion=DB::table('ubicacion')->select(DB::raw('max(id) as id'))->groupBy('id')->get();

        $cliente=new Cliente($request->all());
        $cliente->nombre=$request->get('nombre');
        $cliente->id_ubicacion=$request->get('id_ubicacion');
        $cliente->telefono=$request->get('telefono');


        $cliente->save();
        //dd($personal);
        return redirect('cliente');

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id,$id_servicio)
    {
        //
      
        $cliente=DB::table('cliente as c')
        ->join('nota_servicio as n','n.id_cliente','=','c.id')
        ->join('personal as p','p.id','=','n.id_personal')
        ->join('ubicacion as u','c.id_ubicacion','=','u.id')
        
        ->select('c.nombre','u.nombre as ubicacion','c.telefono','u.x as longitud','u.y as latitud')
        ->where('p.id','=',$id)
        ->where('n.id','=',$id_servicio)->get();

     
   
        return $cliente->toJson();
    }

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
