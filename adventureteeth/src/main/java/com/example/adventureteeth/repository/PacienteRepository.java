package com.example.adventureteeth.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.adventureteeth.model.Paciente;

public interface PacienteRepository extends JpaRepository<Paciente, Long> {
}
