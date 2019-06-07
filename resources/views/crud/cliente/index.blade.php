@extends('layouts.principal')
@section('content')
<div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
          <div class="x_title">
            <h2>Lista de cliente </h2>
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
            <a href="{{route('cliente.create')}}" class="btn btn-success"><i class="fa fa-plus"></i> Agregar cliente</a>
            <a href="{{route('ubicacion.create')}}" class="btn btn-primary"><i class="fa fa-plus"></i> Agregar Ubicacion</a>
            <p class="text-muted font-13 m-b-30">
              Primero Ingrese la Ubicacion del cliente
            </p>


            <div class="table-resonsive">

            <table id="datatable-buttons" class="table table-striped table-bordered table-condensed table-hover">
              <thead>
                <tr>
                
                  
                  <th>Nombre</th>
                  <th>Ubicacion</th>
                  <th>Telefono</th>
                  <th>Operaciones</th>
                </tr>
              </thead>
              <tbody>
                    @foreach($cliente as $c )
                    <tr>
                        <td>{{$c->nombre}}</td>
                        <td>{{$c->ubicacion}}</td>
                        <td>{{$c->telefono}}</td>
                        <td>hola</td>

                    </tr>
                    @endforeach

              </tbody>
            </table>
            </div>
          </div>
        </div>
      </div>

@stop