 %  Combined drone red detection monitor
folder = 'C:\Users\Basani.Chauke\Documents\MATLAB\RedFrames';
if ~exist(folder, 'dir')
    mkdir(folder);
end

% Monitor workspace data
while true
    pause(0.5); 
    try
        val = evalin('base', 'out.detectedFrame.signals.values');
        t   = evalin('base', 'out.detectedFrame.time');
    catch
        continue
    end
    if ~isempty(val)
        frame = squeeze(val(:,:,:,end));
        if size(frame,3) == 3
            timestamp = string(datetime('now','format', 'HHmmss'));
            fname = fullfile(folder, "frame_" + timestamp + ".jpg");
            imwrite(frame, fname);

            % sending an email
            setpref('Internet','E_mail','chaukebasaniangel@gmail.com');
            setpref('Internet','SMTP_Server','smtp.gmail.com');
            setpref('Internet','SMTP_Username','chaukebasaniangel@gmail.com');
            setpref('Internet','SMTP_Password','mzlb munj jhiu utqm');
            
            props = java.lang.System.getProperties;
            props.setProperty('mail.smtp.auth','true');
            props.setProperty('mail.smtp.starttls.enable','true');
            props.setProperty('mail.smtp.port','587');
            body = sprintf('Good day,\n\nI hope this email finds you well.\nAttached is the object that was detected by the drone.\n\nThank you.\n\nKind regards,\nBA Chauke');
            sendmail('basani.chauke@optinum.co.za','red object detected',body,char(fname));
            break;
        end
    end
end