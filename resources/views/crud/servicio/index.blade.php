@extends('layouts.principal')
@section('content')
<div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Lista de servicio </h2>
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
            <a href="{{route('servicio.create')}}" class="btn btn-success"><i class="fa fa-plus"></i> Agregar servicio</a>
            <p class="text-muted font-13 m-b-30">
              Dar click al Boton Agregar servicio.
            </p>
            <div class="table-resonsive">

            <table id="datatable-buttons" class="table table-striped table-bordered table-condensed table-hover">
              <thead>
                <tr>
                
                  <th>Cliente</th>
                  <th>descripcion</th>
                  <th>Fecha-Hora</th>
                  <th>Personal</th>
                  <th>Estado</th>
          
                </tr>
              </thead>
              <tbody>
                    @foreach($nota as $p )
                    <tr>
                        <td>{{$p->cliente}}</td>
                        <td>{{$p->descripcion}}</td>
                        <td>{{$p->fecha_hora}}</td>
                        <td>{{$p->personal}}</td>
                        @if($p->estado==0)
                        <td>pendiente</td>
                        @elseif($p->estado==1)
                        <td>En Proceso</td>
                        @elseif($p->estado==2)
                        <td>finalizado</td>
                        @elseif($p->estado==3)
                        <td>anulado</td>
                        @endif

                    </tr>
                    @endforeach

              </tbody>
            </table>
            </div>
          </div>
        </div>
      </div>

@stop