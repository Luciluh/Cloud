package com.example.adventureteeth.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.adventureteeth.model.Paciente;
import com.example.adventureteeth.repository.PacienteRepository;

@RestController
@RequestMapping("/api/pacientes")
@CrossOrigin(origins = "*")
public class PacienteController {
    
    @Autowired
    private PacienteRepository repo;

    @GetMapping
    public List<Paciente> getAll() {
        return repo.findAll();
    }

    @GetMapping("/{id}")
    public Paciente getById(@PathVariable Long id) {
        return repo.findById(id).orElse(null);
    }

    @PostMapping
    public Paciente create(@RequestBody Paciente paciente) {
        return repo.save(paciente);
    }

    @PutMapping("/{id}")
    public Paciente update(@PathVariable Long id, @RequestBody Paciente paciente) {
        paciente.setId(id);
        return repo.save(paciente);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        repo.deleteById(id);
    }
}
