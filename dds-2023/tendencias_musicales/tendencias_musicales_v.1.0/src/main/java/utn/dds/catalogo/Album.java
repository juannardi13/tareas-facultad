package utn.dds.catalogo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Album {
    private Autor autor;
    private String nombre;
    private int anio;
}
