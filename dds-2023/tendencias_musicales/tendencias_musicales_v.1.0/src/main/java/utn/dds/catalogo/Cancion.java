package utn.dds.catalogo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Cancion {
    private int anio;
    private Autor autor;
    private Album album;
    private int cantDislikes;
    private int cantLikes;
    private int cantResproducciones;


}