<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Marcado;
use App\Personal;
use App\Contrato;
use App\Horario;

class HorariosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        $personal=DB::table('personal')->where('estado','>=','0')->get();
        $horario=DB::table('horario')->get();
        return view('crud.contrato.create',["personal"=>$personal,"horario"=>$horario]);
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


        $hora_diaria=0;
        
        if($horas_extras->$fecha_ini)
        
        $marcado=DB::table('marcado as m')
        ->join('personal as p','c.id_personal','=','p.id')
        ->join('horario as h','c.id_horario','=','h.id')
        ->select('c.nombre','p.nombre as personal','c.tarifa','c.fecha_ini','c.fecha_fin','h.nombre as horario')
        ->orderBy('c.id')->get();
        
        
        $monto->


        $horas_extras->save();
        //dd($personal);
        return redirect('contrato');


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