process MAPTRACK {
    label 'process_high'

    container 'sviatsidorov/uniqmaptrack:1.1'

    input:
    tuple path(fai), path(fasta)

    output:
    path "t2t-chm13-v1.1.fa.sa"     , emit: sa
    path "t2t-chm13-v1.1.fa.gz.gzi" , emit: gzi
    path "t2t-chm13-v1.1.fa.refrev" , emit: refrev
    path "t2t-chm13-v1.1.fa.mul.wig", emit: mul
    path "t2t-chm13-v1.1.fa.mur.wig", emit: mur
    path "versions.yml"             , emit: versions
    
    // ./find_minUniqueKmer.sh ${fasta} $task.cpus
    // ./find_minUniqueKmer.sh ${fasta} $task.cpus
    // /minUniqueKmer/find_minUniqueKmer.sh ${fasta} $task.cpus
    
    """
    /minUniqueKmer/find_minUniqueKmer.sh ${fasta} $task.cpus
    
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        minUniqueKmer: \$(/minUniqueKmer/bin/minUniqueKmer | head -1 | sed 's/^.*ver\. //')
    END_VERSIONS
    """
}
