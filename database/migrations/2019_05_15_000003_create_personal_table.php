<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePersonalTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $set_schema_table = 'personal';

    /**
     * Run the migrations.
     * @table personal
     *
     * @return void
     */
    public function up()
    {
        if (Schema::hasTable($this->set_schema_table)) return;
        Schema::create($this->set_schema_table, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id');
            $table->string('nombre', 50);
            $table->integer('cedula');
            $table->longText('huella')->nullable()->default(null);
            $table->longText('foto')->nullable()->default(null);
            $table->integer('id_cargo')->unsigned();
            $table->integer('estado');

            $table->index(["id_cargo"], 'fk_personal_cargo');


            $table->foreign('id_cargo', 'fk_personal_cargo')
                ->references('id')->on('cargo')
                ->onDelete('restrict')
                ->onUpdate('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
     public function down()
     {
       Schema::dropIfExists($this->set_schema_table);
     }
}
