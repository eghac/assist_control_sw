<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Marcado;
use App\Personal;
use App\Contrato;
use App\Horas_extras;
use App\Horario;
use App\Total;
use App\Horas_traba;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;

class Hora_TController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $horas=DB::table('horas_trabaja as h')
        ->join('personal as p','p.id','=','h.id_personal')
        ->select('p.nombre','h.fecha_ini',DB::raw('sum(h.monto) as monto'),DB::raw('sum(h.total)as total'))
        ->groupBy('p.nombre','h.fecha_ini')->get();
                
        //dd($personal);
        //return $personal->toJson();
        return view('crud.horas_t.index',compact('horas'));
   
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
        $total=DB::table('total')->get();
        return view('crud.horas.create',["personal"=>$personal,"total"=>$total]);
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

        $horas_extras=new horas_extras($request->all());
        $horas_extras->tipo=$request->get('tipo');
        $horas_extras->fecha_ini=$request->get('fecha_ini');
        $horas_extras->fecha_final=$request->get('fecha_final');
        $horas_extras->id_personal=$request->get('id_personal');
        $horas_extras->monto='0';
        $horas_extras->save();
        
        $procedimietno=DB::select('CALL horas_extras');
 
        return redirect('horas');
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