@extends('layouts.principal')
@section('content')
<div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Lista de contrato </h2>
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="#">Settings 1</a>
                  </li>
                  <li><a href="#">Settings 2</a>
                  </li>
                </ul>
              </li>
              <li><a class="close-link"><i class="fa fa-close"></i></a>
              </li>
            </ul>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <a href="{{route('contrato.create')}}" class="btn btn-success"><i class="fa fa-plus"></i> Agregar contrato</a>
            <p class="text-muted font-13 m-b-30">
              Dar click al Boton Agregar contrato.
            </p>
            <div class="table-resonsive">

            <table id="datatable-buttons" class="table table-striped table-bordered table-condensed table-hover">
              <thead>
                <tr>
                
                  <th>Tipo</th>
                  <th>Nombre Personal</th>
                  <th>Tarifa</th>
                  <th>Inicio</th>
                  <th>Final</th>
                  <th>Horario</th>
                </tr>
              </thead>
              <tbody>
                    @foreach($contrato as $p )
                    <tr>
                        <td>{{$p->nombre}}</td>
                        <td>{{$p->personal}}</td>
                        <td>{{$p->tarifa}}</td>
                        <td>{{$p->fecha_ini}}</td>
                        <td>{{$p->fecha_fin}}</td>
                        <td>{{$p->horario}}</td>
          

                    </tr>
                    @endforeach

              </tbody>
            </table>
            </div>
          </div>
        </div>
      </div>

@stop