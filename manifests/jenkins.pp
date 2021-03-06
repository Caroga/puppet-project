class project::jenkins {

    package { "jenkins":
        ensure  => present,
        require => Exec["apt-update"]
    }

    package { "jenkins-cli":
        ensure  => present,
        require => Exec["apt-update"]
    }

    service { "jenkins":
        ensure     => running,
        enable     => true,
        hasrestart => true,
        require    => Package["jenkins"]
    }

    exec { "qatools-install":
        command => "pear install pear.phpqatools.org/phpqatools",
        unless => "pear info pear.phpqatools.org/phpqatools",
        require => Exec['pear-auto-discover']
    }

    project::jenkins::plugin {
        "git" : ;
    }

    project::jenkins::plugin {
        "phing" : ;
    }

    project::jenkins::plugin {
        "subversion" : ;
    }

    project::jenkins::plugin {
        "checkstyle" : ;
    }

    project::jenkins::plugin {
        "cloverphp" : ;
    }

    project::jenkins::plugin {
        "dry" : ;
    }

    project::jenkins::plugin {
        "htmlpublisher" : ;
    }

    project::jenkins::plugin {
        "jdepend" : ;
    }

    project::jenkins::plugin {
        "plot" : ;
    }

    project::jenkins::plugin {
        "pmd" : ;
    }

    project::jenkins::plugin {
        "violations" : ;
    }

    project::jenkins::plugin {
        "xunit" : ;
    }

    file {
        "/etc/apache2/sites-enabled/000-default":
        ensure  => present,
        require => Package["apache"],
        source  => "puppet:///modules/project/jenkins/apache/000-default",
        notify  => Service["apache"],
        owner   => 'root',
        group   => 'root',
        mode    => '0644';
    }

}